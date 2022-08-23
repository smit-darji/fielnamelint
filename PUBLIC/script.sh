echo "$CHANGED_FILES"
arr=($CHANGED_FILES)
echo "${arr[@]}"
echo "-----------------------"
echo "arry is :${arr[@]}"
echo "-----------------------"
file_names_to_ignore=("changelog.xml", "pom.xml", "ReadMe.md")
for i in "${!arr[@]}"; do
    echo "========="
    echo "${arr[i]}"
    if [[ "${arr[i]}" == .github* ]]; then
        unset 'arr[i]'
        echo "${arr[i]}"
    fi
done
unique_dirs=()
unique_file_names=()
for i in "${!arr[@]}"; do
    if [[ ! " ${file_names_to_ignore[*]} " =~ " ${arr[i]##*/} " ]]; then
        # echo "unique :${arr[i]##*/}"
        unique_file_names+=(${arr[i]##*/})
    fi
    IFS='/' read -ra path <<< "${arr[i]%/*}/"
    for i in "${path[@]}"; do
        if [[ ! " ${unique_dirs[*]} " =~ " ${i} " ]]; then
            unique_dirs+=(${i})
        fi
    done
done
invalid_dirs=()
for dir in "${unique_dirs[@]}"; do
    if [[ ! "${dir}" =~ ^[A-Z0-9._]*$ ]]; then
        invalid_dirs+=(${dir}) 
        echo "Invalid Dirrectory Name ${dir}"
        exit 1
    fi
done
invalid_file_names=()
fileValidator=[0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$
echo ${fileValidator}
for file_name in "${unique_file_names[@]}"; do

        # echo "file name is :${file_name}"
        # echo "Ignore: ${fileignore}"
        # if [[ "${file_name}" == "${fileignore}" ]]; then 
        #     echo "in contine: ${file_name}"
        #     continue
        #     echo "continue"
        if [[ ! ${file_name} = ${fileValidator} ]]; then
            invalid_file_names+=(${file_name})            
            echo "Invalid FileName : ${file_name}"
            exit 1
        fi

done
if [[ ! -z "$invalid_dirs" || ! -z "$invalid_file_names" ]]; 
    then
        echo "Failed!!"
        if [[ ! -z "$invalid_dirs" ]]; then
            echo "Invalid Directory Names"
            echo "${invalid_dirs[@]}"
        fi
        if [[ ! -z "$invalid_file_names" ]]; then
            echo "Invalid File Names"
            echo "${invalid_file_names[@]}"
        fi
    else
        echo "Success!!"
fi