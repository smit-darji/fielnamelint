
CHANGED_FILES_ARR=(
    "./.github/workflows/terraform-lint.yml" "./1234_ACV_WERT.xml" "./.gitignore" "./terraform/main.tf" "./terraform-master/main.tf" "./terraform/ssm.tf" "./terraform-master/variables.tf"
    )
# array=("${CHANGED_FILES_ARR[@]:1}")
echo ${CHANGED_FILES_ARR[@]}
# List of file names and directory names which will be ignored while validating
file_names_to_ignore=("changelog.xml" "pom.xml" "ReadMe.md" ".gitignore")
directory_names_to_ignore=("changes")
# All files will be ignored inside of this direcories
# directory_names_to_ignore_completely=(".github" "terraform" "terraform-master")
directory_names_to_ignore_completely=()
# Removing file of .github directory as we don't want to run validations on them
for i in "${!CHANGED_FILES_ARR[@]}"; do
    for j in "${!directory_names_to_ignore_completely[@]}"; do
        if [[ "${CHANGED_FILES_ARR[i]}" == "./${directory_names_to_ignore_completely[j]}/"* ]]; then
            unset 'CHANGED_FILES_ARR[i]'
            break
        fi
    done
done
unique_dirs=()
unique_file_names=()
for i in "${!CHANGED_FILES_ARR[@]}"; do
    # Extracting unique file names
    if [[ ! "${unique_file_names[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" && ! "${file_names_to_ignore[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" ]]; then
        unique_file_names+=(${CHANGED_FILES_ARR[i]##*/})
    fi
    # Extracting unique directory names, we will ignore directory names wich is inside directory_names_to_ignore array
    IFS='/' read -ra path <<< "${CHANGED_FILES_ARR[i]%/*}/"
    echo "path is :${path[@]}"
    echo "=========="
    array=(${path[@]})
    unset array[0]
    echo "Trimm dot: ${array[@]}"
    for i in "${array[@]}"; do
        if [[ ! "${unique_dirs[*]}" =~ "${i}" && ! "${directory_names_to_ignore[*]}" == "${i}"  ]]; then
            unique_dirs+=(${i})
        fi
    done
done
invalid_dirs=()
for dir in "${unique_dirs[@]}"; do
    # Creating list of invalid directories
    if [[ ! "${dir}" =~ ^[A-Z0-9._]*$ ]]; then
        invalid_dirs+=(${dir})   
    fi
done  
invalid_file_names=()
for file_name in "${unique_file_names[@]}"; do
    # Creating list of invalid file names
    if [[ ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
        invalid_file_names+=(${file_name})
    fi
done 
if [[ ! -z "$invalid_dirs" || ! -z "$invalid_file_names" ]]; 
    then
        # Workflow is failed because there are some invalid file or directory names 
        echo -e "\033[1mWorkflow Failed!!\033[0m\n"
        if [[ ! -z "$invalid_dirs" ]]; then
            # Print invalid Directory names
            echo -e "\033[2mInvalid Directory Names\033[0m"
            printf '%s\n' "${invalid_dirs[@]}"
            echo -e "\n"
        fi
        if [[ ! -z "$invalid_file_names" ]]; then
            # Print invalid File names
            echo -e "\033[2mInvalid File Names\033[0m"
            printf '%s\n' "${invalid_file_names[@]}"
        fi
        # Marking workflow as failed
        exit 1
    else
        echo -e "\033[1mWorkflow executed successfully!!\033[0m"
        # Marking workflow as successful
        exit 0
fi