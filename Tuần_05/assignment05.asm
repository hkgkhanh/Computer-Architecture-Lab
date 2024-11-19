# Laboratory Exercise 5, Assignment 5

.data
	Input: .space 21 			# Buffer 21 bytes
	Reversed: .space 21			# Buffer 21 bytes
	Message1: .asciiz "Input string: "
	Message2: .asciiz "\nReversed string: "
	
.text
get_string:
	li $v0, 4
 	la $a0, Message1
 	syscall
 	
	li $v0, 8					# Service is read string from console
 	la $a0, Input				# Save input to variable Input
 	li $a1, 21					# maximum size is 21 characters including \0
 	syscall
 	
get_length:
	add $t0,$zero,$zero 			# $t0 = i = 0
	
check_char:
	add $t1, $a0, $t0			# $t1 = $a0 + $t0 = address(string[i])
	lb $t2, 0($t1) 				# $t2 = string[i]
 	beq $t2, $zero, end_of_str 	# is null char?
 	add $t3, $zero, $t2			# $t3 is the last character of the string 
	addi $t0, $t0, 1	 			# i += 1
	j check_char
	
end_of_str:
	bne $t3, '\n', skip
	addi $t0, $t0, -1			# uncount the \n at the end, now $t0 is the length of input string
	
skip:		# from now, the code is for reversing the string


	la $s0, Reversed				# $s0 points to variable Reversed
	addi $t5, $zero, 0			# index of reversed string
	addi $t0, $t0, -1			# last character of Input is Input[len - 1]
	
reverse:
	slt $t4, $t0, $zero			# $t4 = $t0 < 0 ? 1 : 0
	bne $t4, $zero, end_while	# if $t0 < 0 then jump to end_while
	add $t6, $s0, $t5			# $t6 = address(Reversed[i])
	add $t7, $a0, $t0			# $t7 = address(Input[n - 1 - i])
	lb $t7, 0($t7)				# $t7 = Input[n - 1 - i]
	sb $t7, 0($t6)				# Reversed[i] = Input[n - 1 - i]
	addi $t0, $t0, -1			# $t0 -= 1
	addi $t5, $t5, 1				# i += 1
	j reverse					# jump back to loop
	
end_while:	# from now, the code is for outputting the reversed string
	
	li $v0, 4
 	la $a0, Message2
 	syscall
 	
	li $v0, 4
 	la $a0, Reversed
 	syscall
 	
# Algorithm:
# Iterate from 0 to length(input)-1, copy each character input[i] to reversed[n-1-i]
