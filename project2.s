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
	.asciiz "Invalid Input"

input:
	.asciiz ""

.text

main:
	li $v0, 8
	la $a0, input
	li $a1, 1001
	syscall

	la $s0, input

	la $s0, input
	add $t0, $t0, $s0 
	lb $t1, 0($t0)
	
	li $s0, 0 #initialize a counter
	li $t2, 0 #sum variable
	jal removeSpaceprogram
	
continue:	
	li $t0, 4 #counter for loop
	li $s0, 0 #counter for loop

newloop:
	beq $s0, $t0, exit
	add $t3, $t0, $t6
	lb $t4, 0($t3)
	bge $t4, 48, decimal

continuenewloop:
	addi $s0, 1
	j newloop

decimal:
	bge $t4, 58, upper
	addu $t4, $t4, -48
	mult $t4, 35
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	j continuenewloop

lower:
	bge $t4, 122, continuenewloop
	addu $t4, $t4, -87
	mult $t4, 35
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	add $t2, $t2, $t4
	sll $t2, $t2, 4
	j continuenewloop

upper:
	bge $t4, 97, lower
	bge $t4, 90, continuenewloop
	ble $t4, 64, invalid
	addu $t4, $t4, -55
	mult $t4, 35
	mfhi $t6
	mflo $t7
	add $t4, $t6, $t7
	add $t2, $t2, $t4
	add $t2, $t2, $t4
	sll $t2, $t2, 4
	#add stuff here to do cool base stuff
	j continuenewloop


#space counting loop

removeSpaceprogram:
	addi $t0, $a1, 0 #adds the address of the string 

	loop:
	lb $t0, 0($s0)
	beq $s0, $t0, endLoop
	add $t4, $s0, $t6 #string[i] = t4
	lb $s1, 0($t4) #value of string[i]
	slti $t1, $s1, 33 
	bne $t1, $zero, removeSpace

afterloop:
	addi $s0, $s0, 1
	j removeSpaceloop
	
	
removeSpace:
	add $t5, $s0, $t6
	sb $0, 0($t5)
	addi $s0, $s0, 1
	j removeSpaceloop


endLoop:
	
	j continue

exit:	
	move $a0, $t6
	li $v0, 1
	syscall
	li $v0, 10
	sycall
	
invalid:
	la $a0, output
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	

