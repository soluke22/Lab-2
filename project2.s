# N = 35, '0' to '9', 'a' to 'y', 'A' to 'Y'
# M = 35-10 = 25
#Steps:
#1)Take in a string of up to 1000 characters
#2)Remove leading and trailing blank spaces "  "<-this->"  "
#3)If the string is: a) 0 characters b) greater than 4 characters or
#	c)has one illegal character
#4)If the string contains allowed characters, 
#	convert the character to its decimal equivalent i.e. a = 10

.data

output:
	.asciiz "\Invalid Input \n"

input:
	.asciiz "\Input: \n"

buffer:
	.asciiz ""


.text


main:

	la $a0, input #asks for input
	la $a1, 1000 #string length
	li $v0, 8 #inputs a string
	move $t0, $a0
	syscall

	li $s0, 0 #initialize a counter
	li $t1, 1000
	move $a0, $t0
	j removeSpace

#space counting loop

removeSpace:
	beq $s0, $t0, endLoop
	add $t4, $s0, $a0 #string[i] = t4
	lb $s1, 0($t4) #value of string[i]

endLoop:

	
	