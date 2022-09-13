import re
import os


print ("-------------------------In Python File ---------------------------------------")
CHANGED_FILES_ARR = (os.environ.get('CHANGED_FILES'))
CHANGED_FILE_LIST = CHANGED_FILES_ARR.split(" ")
# Getting Environment variable named CHANGED_FILES and storing it as an array named CHANGED_FILES_ARR
file_names_to_ignore = ["README.md", ".gitignore"]

print("CHANGED_FILE_LIST is ::: ", CHANGED_FILE_LIST)
# CHANGED_FILE_LIST = ['./.github/workflows/test.yml', './.gitignore', './1234_YOGESH_TEST_12T.py', './ABCD/1234_YOGESH_TEST_12T.txt', './Terraform/1234_YOGESH_TEST_12T.txt']

directory_names_to_ignore_completely = [".github", "Terraform",".gitignore"]
directory_names_to_ignore_list = []
print("-------------------Changed File-----------------------------")
for i in CHANGED_FILE_LIST:
    for j in directory_names_to_ignore_completely:
        if (j in i):
            print("directory_names_to_ignore_completely : ",i)
            CHANGED_FILE_LIST.remove(i)
            break
print("After remove :" ,CHANGED_FILE_LIST)
            
# print("-------------------unique File-----------------------------")
# unique_file_names=[]
# for i in CHANGED_FILE_LIST:
#     if (i in CHANGED_FILE_LIST ):
#         print("i is in if " ,i)
#         unique_file_names = unique_file_names+CHANGED_FILE_LIST
#         Unique_File_Name_Only=[]
#         for i in unique_file_names:
#             Unique_File_Name_Only.append(i.split('/')[-1])
#         print("Unique FileName",Unique_File_Name_Only)
# print("-------------------Invalid File-----------------------------")

# invalid_file_names=[]
# file_name_list=[]
# for file_name in Unique_File_Name_Only:
#     match = re.search("[0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$", file_name)
#     if match:
#         print("valid Filename:",file_name)
#     else:
#         print(file_name)
#         file_name_list.append(file_name)
#         print(type(invalid_file_names))
#         print(type(file_name_list))
#         invalid_file_names = invalid_file_names + file_name_list
#         print("invalid File Name: ", invalid_file_names)
#         exit(0)

