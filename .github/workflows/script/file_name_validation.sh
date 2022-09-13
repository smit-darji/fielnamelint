# Getting Environment variable named CHANGED_FILES and storing it as an array named CHANGED_FILES_ARR
CHANGED_FILES_ARR=($CHANGED_FILES)

# List of file names and directory names which will be ignored while validating
file_names_to_ignore=("README.md", ".gitignore")

# All files will be ignored inside of this direcories
directory_names_to_ignore_completely=(".github")

# Removing file of .github directory as we don't want to run validations on them
for i in "${!CHANGED_FILES_ARR[@]}"; do
    for j in "${!directory_names_to_ignore_completely[@]}"; do
        if [[ "${CHANGED_FILES_ARR[i]}" == "./${directory_names_to_ignore_completely[j]}/"* ]]; then
            echo "........"${CHANGED_FILES_ARR[i]}
            unset 'CHANGED_FILES_ARR[i]'
            break
        fi
    done
done

unique_file_names=()

for i in "${!CHANGED_FILES_ARR[@]}"; do
    # Extracting unique file names
    if [[ ! "${unique_file_names[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" && ! "${file_names_to_ignore[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" ]]; then
        unique_file_names+=(${CHANGED_FILES_ARR[i]##*/})
    fi

done

invalid_file_names=()
for file_name in "${unique_file_names[@]}"; do
    # Creating list of invalid file names
    if [[ ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
        invalid_file_names+=(${file_name})
    fi
done 

if [[ ! -z "$invalid_file_names" ]]; 
    then
        # Workflow is failed because there are some invalid file
        echo -e "\033[1mWorkflow Failed!!\033[0m\n"
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