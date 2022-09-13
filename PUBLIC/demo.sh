
# declare -a arr=('aa' 'bb' 'cc' 'dd' 'ee')
# unset 'arr[0]'
# declare -a arr2=()
# i=0
# for element in ${arr[@]}
# do
#     arr2[$i]=$element
#     ((++i))
# done
# echo ${arr[@]}

CHANGED_FILES_ARR=(
    "./.github/workflows/terraform-lint.yml" "./1234_ACV_WERT.xml" "./.gitignore" "./terraform/main.tf" "./terraform-master/main.tf" "./terraform/ssm.tf" "./terraform-master/variables.tf"
    )
unset 'CHANGED_FILES_ARR[0]'
declare -a arr2=()
# j=0
for i in "${!CHANGED_FILES_ARR[@]}"; do
    IFS='/' read -ra path <<< "${CHANGED_FILES_ARR[i]%/*}/"
    unset path[0]
    echo "Trimm dot: ${path[@]}"
done
