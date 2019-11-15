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
zeropower:
	.word 1
firstpower:
	.word 35
secondpower:
	.word 1225
thirdpower:
	.word 42875

.text

main:
	li $v0, 8
	la $a0, input
	li $a1, 1001
	syscall
	la $s0, input#loads the input address into an address saved by subroutines

firstloop:#removes spaces
	add $s0, $s0, $t0
	lb $s1, 0($s0)
	ble $s1, 32, space
	jal secondloop

space:
	addi $t0, $t0, 1
	j firstloop
	
secondloop:
	li $s2, -1
	add $s0, $s0, $t0
	lb $s1, 0($s0)
	bge $t1, 5, invalid
	
	beq $s0, 10, multiply
	beq $s0, 0, multiply
	beq $s1, 47, invalid
	ble $s1, 57, integer
	ble $s1, 64, invalid
	ble $s1, 89, integer
	ble $s1, 96, invalid
	ble $s1, 121, integer
	

integer:
	addu $s1, $s1, 1
	mult $t2, $t2,$s2
	j secondloop


multiply:


invalid:
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 10
	syscall
	
	
	