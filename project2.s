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
	.asciiz ""


.text


main:

	la $a0, input #asks for input
	la $a1, 1000 #string length
	li $v0, 8 #inputs a string
	syscall

	li $s0, 1000 #initialize a counter
	li $t1, 1000
	li $t5, 0 #sum variable
	li $t6, 0 #another counter variable
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

	slti $t1, $s1, 122 #less than 122
	beq $t1, $zero, invalid_input
afterloop:
	addi $s0, $s0, -1
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

decimal:
	bge $s1, 58, upper
	li $t3, 0 #creates a loop for an exponent
	beq $t3, s1, afterdecimal #if t3 = s1, loop is complete
	
	

lower:
	bge $s1, 122, afterloop

upper:
	bge $t4, 97, lower
	bge $t4, 90, afterloop
	ble $t4, 64, afterloop

	