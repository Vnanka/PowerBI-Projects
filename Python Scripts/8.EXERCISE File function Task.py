# -*- coding: utf-8 -*-
"""
Created on Sat Oct 26 15:15:24 2019

@author: giles
"""

# Exercises

'''
Question 1
Create a function that will calculate the sum of two numbers. Call it sum_two.
'''

def sum_two(x,y):
    print('The sum of 2 numbers = ', x+y)
    
x = input('Please enter your first number:  ')
y = input('Please enter your second number:  ')

while not x.isdigit() or not y.isdigit():
    print('Both should be numbers, please try again:')
    x = input('Please enter your first number:  ')
    y = input('Please enter your second number:  ')
else:
    x = int(x)
    y = int(y)
    sum_two(x,y)
   
'''
Question 2
Write a function that performs multiplication of two arguments. By default the
function should multiply the first argument by 2. Call it multiply.
'''

def multiply(x,y):
    print('The multiplication of 2 numbers = ', x*y)
    
x = input('Please enter your first number:  ')
y = input('Please enter your second number or leave blank:  ')

while not x.isdigit() or not y.isdigit() and not y=='':
    print('Both should be numbers, or y should be blank, please try again:')
    x = input('Please enter your first number:  ')
    y = input('Please enter your second number or leave blank:  ')
else:
    if y=='':
        x=int(x)
        y=int(2)
        multiply(x,y)
    else:
        x = int(x)
        y = int(y)
        multiply(x,y)

#has issues, doesn't exit the bloody loop


def multiply(x,y=2):
    print('The multiplication of 2 numbers = ', x*y)
    
    
x = int(input('Please enter your first number:  '))
y = input('Please enter your second number or leave blank:  ')
if y=='':
    y=2
    multiply(x,y)
else: 
    y=int(y)
    multiply(x,y)

'''
Question 3
Write a function to calculate a to the power of b. If b is not given
its default value should be 2. Call it power.
'''
def multiply(a,b=2):
    print('The multiplication of 2 numbers = ', a**b)
    
    
x = int(input('Please enter your first number:  '))
y = input('Please enter your second number or leave blank:  ')
if y=='':
    y=2
    multiply(x,y)
else: 
    y=int(y)
    multiply(x,y)


'''
Question 4
Create a new file called capitals.txt , store the names of five capital cities
in the file on the same line.
'''

f = open('capitals.txt','w')

f.write('Capital1, Capital2, Capital3, Capital4, Capital5,')

f = open('capitals.txt','r')
print(f.readline())
f.close()

import os

# Get the current working directory
current_directory = os.getcwd()
print("Current working directory:", current_directory)

# Specify the path you want to change to
new_directory = C:\Users\vlad loan\Desktop\Codes\WD

# Change the current working directory
os.chdir('C:\\Users\\vlad loan\\Desktop\\Codes\\WD')

'''
Question 5
Write some code that requests the user to input another capital city.
Add that city to the list of cities in capitals. Then print the file to
the screen.
'''
f = open('capitals.txt','a')

capital = input('Write another capital to insert into the file: ')
f.write(' 'capital + '\n')

f.close()

f = open('capitals.txt','r')
print(f.read())

f.close()

'''
Question 6
Write a function that will copy the contents of one file to a new file.
'''

f = open('capitals.txt','r')
d = open('capitals2.txt','w')

d.write(f.read())

f.close()
d.close()

d = open('capitals2.txt','r')
print(d.read())
d.close()