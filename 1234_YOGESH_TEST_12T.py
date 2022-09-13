import os

print ("-------------------------In Python File ---------------------------------------")
CHANGED_FILES_ARR = (os.environ.get('CHANGED_FILES'))

# Getting Environment variable named CHANGED_FILES and storing it as an array named CHANGED_FILES_ARR

print("-------------------------Declare Variables ---------------------------------------")
file_names_to_ignore = ["README.md", ".gitignore"]

CHANGED_FILE_LIST = CHANGED_FILES_ARR.split(" ")
# CHANGED_FILE_LIST = ['./.github/workflows/1.yml', './.github/workflows/script/file_name_validation.sh',
#                      './.github/workflows/test.yml', './.gitignore', './1234_YOGESH_TEST_12T.py', './ABCD/1234_YOGESH_TEST_12T.txt', './Terraform/1234_YOGESH_TEST_12T.txt']
directory_names_to_ignore_completely = [".github", "Terraform"]
print("CHANGED_FILE_LIST is :: ", CHANGED_FILE_LIST)

print("type is : temp: ", type(CHANGED_FILE_LIST))

for i in CHANGED_FILE_LIST:
    for j in directory_names_to_ignore_completely:
        if (j in i):
            print(f"Matched, CHANGED_FILE_LIST: {i} and directory_names_to_ignore_completely: {j}")
            break
