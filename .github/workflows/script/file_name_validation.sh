CHANGED_FILES_ARR=($CHANGED_FILES)

file_names_to_ignore=("README.md", "Terraform", ".gitignore")

directory_names_to_ignore_completely=(".github")

for i in "${!CHANGED_FILES_ARR[@]}"; do
    for j in "${!directory_names_to_ignore_completely[@]}"; do
        echo "directory_names_to_ignore_completely issssssssssss:::::"${!directory_names_to_ignore_completely[@]}
        if [[ "${CHANGED_FILES_ARR[i]}" == "./${directory_names_to_ignore_completely[j]}/"* ]]; then
            echo "........"${CHANGED_FILES_ARR[i]}
            unset 'CHANGED_FILES_ARR[i]'
            break
        fi
    done
done
echo $CHANGED_FILES_ARR

unique_file_names=()

for i in "${!CHANGED_FILES_ARR[@]}"; do
    if [[ ! "${unique_file_names[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" && ! "${file_names_to_ignore[*]}" =~ "${CHANGED_FILES_ARR[i]##*/}" ]]; then
        unique_file_names+=(${CHANGED_FILES_ARR[i]##*/})
    fi

done
echo "Unique FIle list :"$unique_file_names
invalid_file_names=()
for file_name in "${unique_file_names[@]}"; do
    echo $file_name
    if [[ ! "${file_name}" =~ [0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$ ]]; then
        invalid_file_names+=(${file_name})
    fi
done 

if [[ ! -z "$invalid_file_names" ]]; 
    then
        echo -e "\033[1mWorkflow Failed!!\033[0m\n"
        if [[ ! -z "$invalid_file_names" ]]; then
            echo -e "\033[2mInvalid File Names\033[0m"
            printf '%s\n' "${invalid_file_names[@]}"
        fi
        exit 1
    else
        echo -e "\033[1mWorkflow executed successfully!!\033[0m"
        exit 0
fi