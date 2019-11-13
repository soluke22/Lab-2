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
	
	li $v0, 4
	syscall
	li $v0, 10
	syscall

#space counting loop

removeSpaceloop:
	beq $s0, $t0, endLoop
	add $t4, $s0, $a0 #string[i] = t4
	lb $s1, 0($t4) #value of string[i]
	slti $t1, $s1, 33 
	bne $t1, $zero, removeSpace

	slti $t1, $s1 48
	slti $t2, $s1, 65
	slt $t3, $t1, $t2
	bne $t3, $zero, invalid_input
	
	slti $t1, $s1, 90
	slti $t2, $s1, 97
	slt $t3, $t1, $t2
	bne $t3, $zero, invalid_input

	slti $t1, $s1, 122
	beq $t1, $zero, invalid_input
	addi $s0, $s0, 1
	j removeSpaceloop
	
	
removeSpace:
	add $t5, $s0, $a0
	sb $0, 0($t5)
	addi $s0, $s0, 1
	j removeSpaceloop


endLoop:
	
	move $t0, $a0
	j $ra

invalid_input:
	li $v0,4
	la $a0, output
	syscall
	li $v0, 10
	syscall
	