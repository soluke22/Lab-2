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
	la $s0, input#loads the input address into an address saved by subroutines

firstloop:#removes spaces
	add $s0, $s0, $t1
	lb $s1, 0($s0)
	ble $s1, 32, space
	li $s0, 0
	j secondloop

space:
	addi $t1, $t1, 1
	j firstloop
	
secondloop:
	
	