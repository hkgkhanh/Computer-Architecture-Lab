# Laboratory Exercise 5, Home Assignment 2, Assignment 3

.data
	x: .space 32						# destination string x, empty
	y: .asciiz "Hello"				# source string y
	
.text
strcpy:
	la $a1, y						# $a1 points to string y
	la $a0, x						# $s0 points to string x
	add $s0, $zero, $zero			# $s0 = i = 0
	
L1:
	add $t1, $s0, $a1				# $t1 = i + y[0] = address of y[i]
	lb $t2, 0($t1)					# $t2 = value of $t1 = y[i]
	add $t3, $s0, $a0				# $t3 = i + x[0] = address of x[i]
	sb $t2, 0($t3)					# x[i] = $t2 = y[i]
	
	beq $t2, $zero, end_of_strcpy		# if y[i] == 0, exit
	nop
	addi $s0, $s0, 1					# i += 1
	j L1								# next character
	
end_of_strcpy: