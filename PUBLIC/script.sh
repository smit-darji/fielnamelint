echo "-----------first sh file------------"

git fetch --no-tags --prune --depth=1 origin +refs/heads/Master:refs/remotes/origin/Master
echo "::set-output name=changedfiles::$(git diff --name-only --diff-filter=ACMRT origin/Master HEAD)"
# changedfiles=( $(git diff --name-only --diff-filter=ACMRT origin/Master HEAD) )
changedfiles=( $(git diff --name-only --diff-filter=ACMRT origin/Master HEAD | uniq | jq -R -s -c 'split("\n")[:-1]' | jq -r '.[] | @sh' | tr -d \') )
echo "-----------------------"
echo ${changedfiles[@]}
echo "-----------------------"
file_names_to_ignore=("changelog.xml", "pom.xml", "ReadMe.md")
for i in "${!changedfiles[@]}"; do
    if [[ "${changedfiles[i]}" == .github* ]]; then
        unset 'changedfiles[i]'
        echo "${changedfiles[i]}"
    fi
done
unique_dirs=()
unique_file_names=()
for i in "${!changedfiles[@]}"; do
    if [[ ! " ${file_names_to_ignore[*]} " =~ " ${changedfiles[i]##*/} " ]]; then
        unique_file_names+=(${changedfiles[i]##*/})
    fi
    IFS='/' read -ra path <<< "${changedfiles[i]%/*}/"
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
        echo ${dir}
        echo "Invalid Dirrectory Name"
        exit 1
    fi
done  
invalid_file_names=()
for file_name in "${unique_file_names[@]}"; do
    if [[ ! " ${file_names_to_ignore[*]} " =~ " ${changedfiles[i]##*/} " ]]; then
          echo " ${changedfiles[i]##*/} " 
          invalid_file_names+=(${file_name})
          exit 0                           
    
    elif ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
          invalid_file_names+=(${file_name})
          echo ${file_name}
          echo "Invalid FileName" 
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
# echo "$CHANGED_FILES"
# readarray -t changedfiles < <("$CHANGED_FILES")
# echo "hello"
# echo "${changedfiles[@]}"

# file_names_to_ignore=("changelog.xml", "pom.xml", "ReadMe.md")

# # Remove files of .github directory from list
# for i in "${!changedfiles[@]}"; do
#     if [[ "${changedfiles[i]}" == .github* ]]; then
#         unset 'changedfiles[i]'
#     fi
# done

# # Get unique directories and file names
# unique_dirs=()
# unique_file_names=()
# for i in "${!changedfiles[@]}"; do
#     if [[ ! " ${file_names_to_ignore[*]} " =~ " ${changedfiles[i]##*/} " ]]; then
#         unique_file_names+=(${changedfiles[i]##*/})
#     fi
#     IFS='/' read -ra path <<< "${changedfiles[i]%/*}/"
#     for i in "${path[@]}"; do
#         if [[ ! " ${unique_dirs[*]} " =~ " ${i} " ]]; then
#             unique_dirs+=(${i})
#         fi
#     done
# done

# # Get Invalid Directory names
# invalid_dirs=()
# for dir in "${unique_dirs[@]}"; do
#     if [[ ! "${dir}" =~ ^[A-Z0-9._]*$ ]]; then
#         invalid_dirs+=(${dir}) 
#     fi
# done

# # Get Invalid Directory names
# invalid_file_names=()
# for file_name in "${unique_file_names[@]}"; do
#     if [[ ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
#         invalid_file_names+=(${file_name}) 
#     fi
# done

# if [[ ! -z "$invalid_dirs" || ! -z "$invalid_file_names" ]]; 
#     then
#         echo "Failed!!"
#         if [[ ! -z "$invalid_dirs" ]]; then
#             echo "Invalid Directory Names"
#             echo "${invalid_dirs[@]}"
#         fi 
#         if [[ ! -z "$invalid_file_names" ]]; then
#             echo "Invalid File Names"
#             echo "${invalid_file_names[@]}"
#         fi
#     else
#         echo "Success!!"
# fi