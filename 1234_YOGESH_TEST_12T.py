from fileinput import filename
import re
import os
from itertools import filterfalse
CHANGED_FILES_ARR = (os.environ.get('CHANGED_FILES'))
CHANGED_FILE_LIST = CHANGED_FILES_ARR.split(" ")
print("CHANGED_FILE_LIST :", CHANGED_FILE_LIST)
file_names_to_ignore = ["README.md", ".gitignore"]
# CHANGED_FILE_LIST = ['./.github/workflows/1.yml', './.github/workflows/script/file_name_validation.sh', './.github/workflows/test.yml', './1234_YOGESH_TEST_12T.py', './ABCD/1234_YOGESH_TEST_12T.txt']
directory_names_to_ignore_completely = [".github", "Terraform",".gitignore"]
directory_names_to_ignore_list = []

REMOVE_DIR_NAME_LIST=[]
for i in CHANGED_FILE_LIST:
    for j in directory_names_to_ignore_completely:
        if (j in i):
            REMOVE_DIR_NAME_LIST.append(i)
CHANGED_FILE_LIST = [i for i in CHANGED_FILE_LIST if i not in REMOVE_DIR_NAME_LIST]
print("CHANGED FILE LIST is :", str(CHANGED_FILE_LIST))
print(type(CHANGED_FILE_LIST))
unique_file_names=[]
for i in CHANGED_FILE_LIST:
    if (i in CHANGED_FILE_LIST ):
        unique_file_names = unique_file_names+CHANGED_FILE_LIST
        Unique_File_Name_Only=[]
        for i in unique_file_names:
            Unique_File_Name_Only.append(i.split('/')[-1])
invalid_file_names=[]
file_name_list=[]
for file_name in Unique_File_Name_Only:
    match = re.search("[0-9]{4}_[A-Z0-9_]*.[a-zA-Z]*$", file_name)
    if match:
        print("valid Filename:",file_name)
    else:
        print("Invalid FIle is :",file_name)
        file_name_list.append(file_name)
        invalid_file_names = invalid_file_names + file_name_list
        # print("invalid File Name: ", invalid_file_names)
        # os.environ["outputvar"] = filename
        # print("Os env is :::",os.environ["outputvar"])
        exit(1)

