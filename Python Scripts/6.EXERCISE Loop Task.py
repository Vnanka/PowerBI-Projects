#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 20 08:50:32 2019

@author: Giles
"""

'''
Question 1
Ask the user for two numbers between 1 and 100. Then count from the
lower number to the higher number. Print the results to the screen.
'''
x = int(input('Insert a number from 1 to 100:   '))
y = int(input('Insert a number from 1 to 100:   '))

if x > y:
    for i in range(y,x+1):
        print(i, end=' ')
elif y > x:
    for i in range(x,y+1):
        print(i, end=' ')
else:
    print(x)


'''
Question 2
Ask the user to input a string and then print it out to the screen in
reverse order (use a for loop).
'''
x = input('Write a word broskiskiski:    ')
y=0
for i in x:
    y -=1
    print(x[y], end = '')

'''
Question 3
Ask the user for a number between 1 and 12 and then display a times
table for that number.1
'''
x = int(input('put a number between 1 and 12:    '))
if x >= 1 and x <= 12:
    for i in range (0,11):
        print(x,'*',i,'=',x*i)
else:
    print('Number out of range suka ')
    try_again = input("Would you like to try again? (yes/no): ").strip().lower()
    if try_again == 'yes':
        print("Let's try again!")
    elif try_again == 'no':
            print("Goodbye!")
    else:
            print("Invalid input. Please enter 'yes' or 'no'.")
            x = int(input('put a number between 1 and 12:    '))


while True:
    x = int(input('Put a number between 1 and 12: '))
    
    if 1 <= x <= 12:
        for i in range(0, 11):
            print(x, '*', i, '=', x * i)
        break  
    else:
        print('Number out of range.')
        try_again = input("Would you like to try again? (yes/no): ").strip().lower()

        if try_again == 'yes':
            print("Let's try again!")
            continue  
        elif try_again == 'no':
            print("Goodbye!")
            break  
        else:
            print("Invalid input. Please enter 'yes' or 'no'.")



while True:
    try:
        x = int(input('Put a number between 1 and 12: '))
        
        if 1 <= x <= 12:
            # Print multiplication table if input is within the valid range
            for i in range(0, 11):
                print(x, '*', i, '=', x * i)
            break  # Exit the loop after printing the multiplication table
        else:
            print('Number out of range.')
            
            while True:  # Inner loop for asking if the user wants to try again
                try_again = input("Would you like to try again? (yes/no): ").strip().lower()
                
                if try_again == 'yes':
                    print("Let's try again!")
                    break  # Break inner loop and restart the outer loop
                elif try_again == 'no':
                    print("Goodbye!")
                    exit()  # Exit the program completely
                else:
                    print("Invalid input. Please enter 'yes' or 'no'.")
    except ValueError:
        print("Invalid input. Please enter a valid number between 1 and 12.")

x = input('Number between 1 and 12      ')
while (not x.isdigit()) or int(x) > 12 or int(x) < 1:
    x = input('again :     ')
x = int(x)
for i in range(1,11):
    print(f'{x} *  {i} = ', x*i)

'''
Question 4
Can you amend the solution to question 3 so that it just prints out all
times tables between 1 and 12? (no  need to ask user for input)
'''

for z in range (1,13):
    print('\ntimes table for', z,)
    for i in range (1,13):
        print(z,'*',i,'=',z*i)
    

'''
Question 5
Ask the user to input a sequence of numbers. Then calculate the mean
and print the result
'''

count = 0
average_set = []
user_input = int(input('Broski insert a number, insert something else instead of number to stop with your sequence:    '))
count +=1
while True:
    try:
        user_input = int(input(f'you inserted {user_input}, now you have {count} numbers in the set, insert next number:   '))
        count +=1
        average_set.append(user_input)
    except ValueError:     
        average = sum(average_set) / len(average_set)
        print(f'sequence is complete and contains {count} numbers, the average of this set is {average}')
        break

'''
Question 6
Write code that will calculate 15 factorial. (factorial is product of
positive ints up to a given number. e.g 5 factorial is 5x4x3x2x1)
'''
x = 1
empty_set = []
for i in range(1,16):
    x = x * i
print('Factorial of 15 = ', x)
    



'''
Question 7
Write code to calculate Fibonacci numbers. Create list containing
first 20 Fibonacci numbers, (Fib  numbers made by sum of preceeding
two. Series starts 0 1 1 2 3 5 8 13 ....)
'''

x=0
z=0
y=1
fibonacci_list = []
for i in range(0,20):
    x=z
    fibonacci_list.append(x)
    z=x+y
    y=x
print(fibonacci_list)
print(len(fibonacci_list))


'''
Question 8
The previous question was the first to contain comments. Go back
through the other questions in this file and add comments to the
solutions.
'''

'''
Question 9

     *****
     *
     ****
     *
     *
     *
Can you draw this using python? (comment the solution code)
'''
print('*****\n*\n****\n*\n*\n*')


star = '*'

for i in range(1,7):
    for j in range(1,6):
        if i == 1 and j < 6:
            print(star, end='')
        elif i == 2 and j == 1:
            print()
            print(star)
        elif i == 3 and j < 5:
            print(star, end='')
        elif i == 4 and j == 1:
            print()
            print(star)
        elif i == 5 and j == 1:
            print(star)
        elif i == 4 and j == 1:
            print(star)
'''
Question 10
Write some code that will determine all odd and even numbers
between 1 and 100. Put the odds in a list named odd and the evens
in a list named even.
'''

even = []
odd = []
for i in range (1,101):
    if i % 2 == 0:
        even.append(i)
    else:
        odd.append(i)
print(even,odd)
        