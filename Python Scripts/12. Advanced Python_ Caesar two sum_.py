
# Ceasar sipher 

user_input = input('Input text for encrypting:   ')
user_input = user_input.upper()
encryption_key = int(input('Input encryption key:    '))

alphabet = {
    1 : 'A',
    2 : 'B', 
    3 : 'C',  
    4 : 'D', 
    5 : 'E',  
    6 : 'F',  
    7 : 'G',  
    8 : 'H',  
    9 : 'I',  
    10 : 'J',  
    11 : 'K',  
    12 : 'L',
    13 : 'M',
    14 : 'N', 
    15 : 'O',  
    16 : 'P', 
    17 : 'Q',  
    18 : 'R',  
    19 : 'S',  
    20 : 'T',  
    21 : 'U',  
    22 : 'V',  
    23 : 'W',  
    24 : 'X',    
    25 : 'Y',  
    26 : 'Z'
    }

reverse_alphabet = {}

for k, v in alphabet.items():
    reverse_alphabet[v] = k
    
for letter in user_input:
     print(alphabet.get(reverse_alphabet.get(letter)+encryption_key), end = '')

    
    
for number in alphabet.items():
    print(f'{number},',)

'''
# Correct Solution (not my code)

alphabet = 'abcdefghijklmnopqrstuvwxyz'
input_text = 'cat sat on a mat'

# 1
# output = ''

# for letter in input_text:
#     letter_index = alphabet.find(letter)
#     output = output + alphabet[letter_index+3]
# print(output)

def shift_amount(i):
    return i % 26

# for letter in input_text:
#     letter_index = alphabet.find(letter)
#     output = output + alphabet[shift_amout(letter_index + 30)]
# print(output)


def encrypt_text(text, required_shift):

        output=''
        for letter in text:
            if letter not in alphabet:
                output = output + letter
            else:
                letter_index = alphabet.find(letter)
                output = output + alphabet[shift_amount(letter_index + required_shift)]
        print(output)
'''    
    
    
# Two Sum (My Code)
my_list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,
           19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,
           36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,
           54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,
           73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,
           93,94,95,96,97,98,99,100]

for i in my_list:
    print(i%26)


def two_sum(my_list, required_sum):
    
    my_list = [2,5,4,3,7,9]
    newlist = [] 
    for i in my_list:
        for d in my_list:
            d = i +1
            if i + d == required_sum:
                newlist.insert(i,d)
    print(newlist)
    
'''    
#Correct Solution (Not my Code)


l1 = [2,3,5,7]
def two_sum2(num, target):
    
    d = {}
    
    
    
    for i in range(len(num)):
        if target - num[i] in d:
            print(d)
            return [d[target-num[i],i]]
            
        d[num[i]] = i
    
    return -1

'''        
        
    


    


