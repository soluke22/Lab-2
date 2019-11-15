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
	.space 1001

.text

main:
	li $v0, 8
	la $a0, input
	li $a1, 1001
	syscall
	jal firstloop
	j done

firstloop:#removes spaces

	la $t0,input
	add $t0,$t0,$t1
	lb $s0, ($t0)
	beq $s0, $0, done
	beq $s0, 9, space
	beq $s0, 32, space
	move $t6, $t1
	j secondloop

space:
	addi $t1, $t1, 1
	j firstloop
	
secondloop:
	li $t7, -1
	la $t0,input
	add $t0,$t0,$t1
	lb $s0, ($t0)
	bge $t2, 5, invalid
	bge $t3, 1, invalid
	addi $t1, $t1, 1
	j checker
checker:
	beq $s0, 9,  space2
	beq $s0, 32, space2
	beq $s0, 10, multiply
	beq $s0, $0, multiply
	ble $s0, 47, invalid
	ble $s0, 57, integer
	ble $s0, 64, invalid
	ble $s0, 89, integer
	ble $s0, 96, invalid
	ble $s0, 121, integer
	bge $s0, 122, invalid

space2:
	addi $t3,$t3, -1
	j secondloop	

integer:
	addi $t2, $t2, 1	
	mul $t3, $t3, $t7
	j secondloop


multiply:
	la $t0, input
	add $t0,$t0,$t6
	lb $s0, ($t0)
	addi $t2,$t2, -1
	addi $t6, $t6, 1
	blt $t2,0, secondloopdone
	move $t8, $t2	
	ble $s0, 57, decimal
	ble $s0, 89, upper
	ble $s0, 121, lower

decimal:
	addu $s0, $s0, -48
	beq $t1, 0, combine
	li $t7, 35
	j compute
upper:
	li $t5, 55
	sub $s0, $s0, $t5
	beq $t2, 0, combine
	li $t9, 30
	j compute

lower:
	li $t5, 87
	sub $s0, $s0, $t5
	beq $t2, 0, combine
	li $t9, 30
	j compute

compute:
	ble $t8, -1, combine
	mul $t9, $t9, 30 
	addi $t8, $t8, -1
	j compute 
	
combine:
	mul $s2, $t9, $s0
	add $s1, $s1, $s2
	li $t9, 1
	j multiply
	

invalid:
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 10
	syscall
	
secondloopdone:
	jr $ra

done:
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 10
	syscall
	