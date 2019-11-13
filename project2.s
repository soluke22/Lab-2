# N = 35, '0' to '9', 'a' to 'y', 'A' to 'Y'
# M = 35-10 = 25
#Steps:
#1)Take in a string of up to 1000 characters
#2)Remove leading and trailing blank spaces "  "<-this->"  "
#3)If the string is: a) 0 characters b) greater than 4 characters or c)has one illegal character
#4)If the string contains allowed characters, convert the charaacter to its decimal equivalent i.e. a = 10

.data 

ask:
	.asciiz "\Input: \n"

input:
	.space 100

.text

main:

	la $a0, ask #asks for input
	li $v0, 4
	syscall

	la $a0,input
	li $a1, 100
	li $v0, 8
	syscall