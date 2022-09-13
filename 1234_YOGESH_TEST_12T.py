import re
import os


print ("-------------------------In Python File ---------------------------------------")
CHANGED_FILES_ARR = (os.environ.get('CHANGED_FILES'))
CHANGED_FILE_LIST = CHANGED_FILES_ARR.split(" ")
# Getting Environment variable named CHANGED_FILES and storing it as an array named CHANGED_FILES_ARR

print("-------------------------Declare Variables ---------------------------------------")
file_names_to_ignore = ["README.md", ".gitignore"]


# CHANGED_FILE_LIST = ['./.github/workflows/test.yml', './.gitignore', './1234_YOGESH_TEST_12T.py', './ABCD/1234_YOGESH_TEST_12T.txt', './Terraform/1234_YOGESH_TEST_12T.txt']
directory_names_to_ignore_completely = [".github", "Terraform"]
print("CHANGED_FILE_LIST is :: ", CHANGED_FILE_LIST)
print("-------------------Changed File-----------------------------")
for i in CHANGED_FILE_LIST:
    for j in directory_names_to_ignore_completely:
        if (j in i):
            print(f"Matched, CHANGED_FILE_LIST: {i} and directory_names_to_ignore_completely: {j}")
            break
print("-------------------unique File-----------------------------")
unique_file_names=[]
for i in CHANGED_FILE_LIST:
    if (unique_file_names != CHANGED_FILE_LIST and file_names_to_ignore != CHANGED_FILE_LIST):
        unique_file_names = unique_file_names+CHANGED_FILE_LIST
        Unique_File_Name_Only=[]
        for i in unique_file_names:
            Unique_File_Name_Only.append(i.split('/')[-1])
        print("Unique FileName",Unique_File_Name_Only)
print("-------------------Invalid File-----------------------------")

invalid_file_names=[]
for file_name in Unique_File_Name_Only:
    match = re.search("[0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$", file_name)
    if match:
        print("valid Filename:",file_name)
    else:
        invalid_file_names = invalid_file_names + file_name
        print("invalid File Name: ", invalid_file_names)
        exit(0)

