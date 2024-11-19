# Laboratory Exercise 4, Assignment 4

.text
	addi $s1, $zero, 0x0fffffff
	addi $s2, $zero, 0x7fffffff	# Initialize $s1 and $s2
	li $t0, 0					# not overflow is default status
	
	xor $t1, $s1, $s2			# check if $s1 and $s2 are the same sign. (>= 0 if same sign, < 0 if not same sign)
	slt $t2, $t1, $zero			# $t2 = $t1 < 0 ? 1 : 0
	bne $t2, $zero, EXIT			# if $t2 < 0 then no overflow, jump to exit
	
	addu $t3, $s1, $s2			# add unsigned $s1 and $s2, save to $t3
	xor $t4, $s1, $t3			# check if sum and $s1 are the same sign. (>= 0 if same sign, < 0 if not same sign)
	slt $t5, $t4, $zero			# $t5 = $t4 < 0 ? 1 : 0
	beq $t5, $zero, EXIT			# if $t5 = 0 then no overflow, jump to exit
	
	li $t0, 1					# The other cases are overflow
	
EXIT:	
