# Laboratory Exercise 5, Assignment 2

.data
	mess1: .asciiz "The sum of "
	mess2: .asciiz " and "
	mess3: .asciiz " is "
	
.text
	addi $s0, $zero, 2	# initialize $s0 and $s1s
	addi $s1, $zero, 5
	add $s3, $s0, $s1	# $s3 = $s0 + $s1
	
	li $v0, 4			# service is printing string
	la $a0, mess1		# string to print is "The sum of "
	syscall				# execute
	
	li $v0, 1			# serice is printing integer
	la $a0, ($s0)		# integer to print is in $s0
	syscall				# execute
	
	li $v0, 4			# service is printing string
	la $a0, mess2		# string to print is " and "
	syscall				# execute
	
	li $v0, 1			# service is printing integer
	la $a0, ($s1)		# integer to print is in $s1
	syscall				# execute
	
	li $v0, 4			# service is printing string
	la $a0, mess3		# string to print is " is "
	syscall				# execute
	
	
	li $v0, 1			# service is printing integer
	la $a0, ($s3)		# integer to print is in $s3, it is the sum of $s0 and $s1
	syscall				# execute