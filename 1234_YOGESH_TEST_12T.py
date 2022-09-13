import os

print ("-------------------------In Python File ---------------------------------------")
CHANGED_FILES_ARR = (os.environ.get('CHANGED_FILES'))

# Getting Environment variable named CHANGED_FILES and storing it as an array named CHANGED_FILES_ARR
print("Arrys is :::", CHANGED_FILES_ARR)

print ("-------------------------Declare Variables ---------------------------------------")
# List of file names and directory names which will be ignored while validating
file_names_to_ignore = ["README.md", ".gitignore"]

# All files will be ignored inside of this direcories
directory_names_to_ignore_completely = [".github"]

print("file_names_to_ignore is :::", file_names_to_ignore)
print("directory_names_to_ignore_completely ::", directory_names_to_ignore_completely)

print ("-------------------------Removing file of .github directory---------------------------------------")

# Removing file of .github directory as we don't want to run validations on them
for i in CHANGED_FILES_ARR:
    print("iis: ",i)



# for i in "${!CHANGED_FILES_ARR[@]}"; do
#     for j in "${!directory_names_to_ignore_completely[@]}"; do
#         if [[ "${CHANGED_FILES_ARR[i]}" == "./${directory_names_to_ignore_completely[j]}/"* ]]; then
#             unset 'CHANGED_FILES_ARR[i]'
#             break
#         fi
#     done
# done
