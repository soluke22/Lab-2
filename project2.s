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
	la $a1, 1001 #string length
	li $v0, 8 #inputs a string
	move $t6, $a0
	syscall

	li $s0, 0 #initialize a counter
	li $t0, 1000 #counter for space loop
	li $t2, 0 #sum variable
	li $t3, 35#for multiplying
	j removeSpaceloop
	#space counting loop

removeSpaceloop:
	beq $s0, $t0, continue
	add $t4, $s0, $t6 #string[i] = t4
	lb $s1, 0($t4) #value of string[i]
	slti $t1, $s1, 33 
	bne $t1, $zero, removeSpace

removeSpace:
	add $t5, $s0, $t6
	sb $0, 0($t5)
	addi $s0, $s0, 1
	j removeSpaceloop

afterloop:
	addi $s0, $s0, 1
	j removeSpaceloop

continue:	
	li $t0, 4 #counter for loop
	li $s0, 0 #counter for loop
	li $t1, 4

newloop:
	beq $s0, $t0, exit
	beq $t4, $0, invalid
	add $t3, $t0, $t6
	lb $t4, 0($t3)
	bge $t4, 48, decimal

continuenewloop:
	addi $s0, 1
	addi $t4, -1
	j newloop

decimal:
	bge $t4, 58, upper
	addu $t4, $t4, -48
	mult $t4, $t3
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	j continuenewloop

lower:
	bge $t4, 122, continuenewloop
	addu $t4, $t4, -87
	mult $t4, $t3
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	add $t2, $t2, $t4
	j continuenewloop

upper:
	bge $t4, 97, lower
	bge $t4, 90, continuenewloop
	ble $t4, 64, continuenewloop
	addu $t4, $t4, -55
	mult $t4, $t3
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	add $t2, $t2, $t4
	#add stuff here to do cool base stuff
	j continuenewloop


exit:	
	move $a0, $t2
	li $v0, 1
	syscall
	li $v0, 10
	syscall

invalid:
	la $a0, output
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	