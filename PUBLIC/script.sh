echo "$CHANGED_FILES"
arr=($CHANGED_FILES)
echo "${arr[@]}"
echo "-----------------------"
echo ${CHANGED_FILES[@]}
echo "-----------------------"
file_names_to_ignore=("changelog.xml", "pom.xml", "ReadMe.md")
for i in "${!CHANGED_FILES[@]}"; do
    echo "========="
    echo "${CHANGED_FILES[i]}"
    if [[ "${CHANGED_FILES[i]}" == .github* ]]; then
        unset 'CHANGED_FILES[i]'
        echo "${CHANGED_FILES[i]}"
    fi
done
unique_dirs=()
unique_file_names=()
for i in "${!CHANGED_FILES[@]}"; do
    if [[ ! " ${file_names_to_ignore[*]} " =~ " ${CHANGED_FILES[i]##*/} " ]]; then
        echo "-------------"
        echo "${CHANGED_FILES[i]##*/}"
        unique_file_names+=(${CHANGED_FILES[i]##*/})
    fi
    IFS='/' read -ra path <<< "${CHANGED_FILES[i]%/*}/"
    for i in "${path[@]}"; do
        if [[ ! " ${unique_dirs[*]} " =~ " ${i} " ]]; then
            echo "==========="
            echo "${i}"
            unique_dirs+=(${i})
        fi
    done
done
invalid_dirs=()
for dir in "${unique_dirs[@]}"; do
    if [[ ! "${dir}" =~ ^[A-Z0-9._]*$ ]]; then
        invalid_dirs+=(${dir}) 
        
    fi
done  

invalid_file_names=()
for file_name in "${unique_file_names[@]}"; do
    if [[ ! " ${file_names_to_ignore[*]} " =~ " ${CHANGED_FILES[i]##*/} " ]]; then
        exit 0                           
    fi
    if [[ ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
        invalid_file_names+=(${file_name})
        echo ${file_name}
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
        exit 1
    else
        echo "Success!!"
        exit 0
fi
