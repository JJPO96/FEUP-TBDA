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
    
'''
    
    file = open(sys.argv[1],'r+')
    file.seek(0)
    file.truncate
    file.write(file.replace('},{','}\n{'))
    file.close()

    dataset_exists = os.path.isfile(dataset_path + sys.argv[1])
    model_exists = os.path.isfile(models_path + sys.argv[2])

    if(not dataset_exists):
        print(
            "There is no dataset on the folder 'dataset' named " + sys.argv[1])
    elif(not model_exists):
        print("There is no model on the folder 'models' named " + sys.argv[2])
    else:
        Test(sys.argv[1], sys.argv[2])
'''
