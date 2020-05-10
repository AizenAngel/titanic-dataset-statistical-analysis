import pandas as pd 
import re


TEST_PATH = 'Titanic/test.csv'
TRAIN_PATH = 'Titanic/train.csv'

DATA_FOLDER_PATH = 'Titanic/'

def extract_names_surnames(fpath: str, new_fpath) -> None:

    df = pd.read_csv(fpath)
    names_surnames = df['Name']
    print(names_surnames)
    names = []
    surnames = []

    #? It will extract surname, and the first name in encounters, eg: Frolicher-Stehli, Mrs. Maxmillian (Margaretha Emerentia Stehli)
    #? will return Maximilian for name and Frolicher-Stehli for surname
    regex = re.compile(r'(?P<surname>.*), .*\. (?P<name>\w+\s{0,1}\w+)', re.I)
    regex_for_special_cases = re.compile(r'(?P<surname>.*),.*\((?P<name>\w+)', re.I)
    
    for item in names_surnames:
        match = regex.match(item)
        if match:
            names.append(match.group('name'))
            surnames.append(match.group('surname'))

        else:
            match = regex_for_special_cases.match(item)
            if match:
                names.append(match.group('name'))
                surnames.append(match.group('surname'))
            else:
                print('no match for', item)


    df.drop('Name', axis=1, inplace=True)
    df['Name'] = names
    df['Surname'] = surnames
    print('Extracted names number: ', len(names))
    print('Extracted surnames number: ', len(surnames))


    df.to_csv(new_fpath)

if __name__ == "__main__":
    new_test_fpath = DATA_FOLDER_PATH + '/extracted_test.csv'
    extract_names_surnames(TEST_PATH, new_test_fpath)

    new_train_fpath = DATA_FOLDER_PATH + '/extracted_train.csv'
    extract_names_surnames(TRAIN_PATH, new_train_fpath)
