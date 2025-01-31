#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 17 13:04:18 2019

@author: Giles - Exercise Author
@Exercise_Completion: Vladislavs Nanaks
"""

'''
Question 1
Write code that asks the user to input a number between 1 and 5 inclusive.
The code will take the integer value and print out the string value. So for
example if the user inputs 2 the code will print two. Reject any input that
is not a number in that range
'''

their_number = int(input('Please input a number between 1 and 5 inclusive \n\t>>> '))

if their_number == 1:
    print('one')
elif their_number == 2:
    print('two')
elif their_number == 3:
    print('three')
elif their_number == 4:
    print('four')
elif their_number == 5:
    print('five')
elif their_number < 1 or their_number > 5:
    print('value out of range')
else:
    print('This is not a number')
    
    
    
'''
Question 2
Repeat the previous task but this time the user will input a string and the
code will ouput the integer value. Convert the string to lowercase first.
'''
their_number = input('Please input a a number between 1 and 5 inclusive in writing\n\t>>> ')
their_number = their_number.lower()
if their_number.lower() == 'one':
    print(int(1))
elif their_number.lower() == 'two':
    print(int(2))
elif their_number.lower() == 'three':
    print(int(3))
elif their_number.lower() == 'four':
    print(int(4))
elif their_number.lower() == 'five': # no need to put int() can just put print(5)
    print(int(5))
else:
    print('Wrong input')
    
'''
Question 3
Create a variable containing an integer between 1 and 10 inclusive. Ask the
user to guess the number. If they guess too high or too low, tell them they
have not won. Tell them they win if they guess the correct number.
'''
x = 5

your_value = int(input('Guess the number : '))

if your_value > x:
    print('Your number is bigger, you lost')
elif your_value < x:
    print('Your number is lower, you lost')
elif your_value == x:
    print('Your won, the correct number is 5!!!! Congrads!')
else:
    print('You entered some straaaange things you have entered')




'''
Question 4
Ask the user to input their name. Check the length of the name. If it is
greater than 5 characters long, write a message telling them how many characters
otherwise write a message saying the length of their name is a secret
'''

their_name = input('Enter your name broski:  ')
if len(their_name) > 5:
    print('Your name is ', len(their_name), ' characters long' )
else:
    print('The length of your name is a secret')
    
    
    
'''
Question 5
Ask the user for two integers between 1 and 20. If they are both greater than
15 return their product. If only one is greater than 15 return their sum, if
neither are greater than 15 return zero
'''

print('Add two numbers between 1 and 20')
x = int(input('Insert your first number here:  '))
y = int(input('Now insert your second number here:  '))

if x > 15 and y > 15:
    print('The product of your numbers is ', x*y)
elif x > 15 or y > 15:
    print('The sum of your values is ', x+y)
else:
    print(0)

    
'''
Question 6
Ask the user for two integers, then swap the contents of the variables. So if
var_1 = 1 and var_2 = 2 initially, once the code has run var_1 should equal 2
and var_2 should equal 1.
'''

print('Input two numbers')
var_1 = int(input('Insert your first number here:  '))
var_2 = int(input('Now insert your second number here:  '))

var_3 = var_1
var_1 = var_2
var_2 = var_3

print('HAHAHAHHAHAHHA, your numbers are now swapped!!!! First number is ', var_1, ' and your second number is ', var_2)
