import os
import sys

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

def Test(a):
    print(a)


if __name__ == "__main__":
    if(len(sys.argv) != 2):
        print("Number of arguments incorrect.\nMust be: python3 format_exp.py [name_of_file]")
    
    with open(sys.argv[1],'r+', encoding="utf8") as file:
        data = file.read()
        rep = data.replace('},{','}\n{')
        file.seek(0)
        file.truncate
        file.write(rep)
