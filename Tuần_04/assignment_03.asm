# Laboratory Exercise 4, Assignment 3

.text
	addi $s1, $zero, 0x2 # Initialize $s1 and $s2 for all 4 problems
	addi $s2, $zero, 0x1
	# a) abs $s0, $s1
	add $s0, $s1, $zero		# $s0 := $s1
	slt $t0, $s0, $zero		# $t0 = $s0 < 0 ? 1 : 0
	beq $t0, $zero, POSITIVE	# if $s0 >= 0 then jump pass the next code
	sub $s0, $zero, $s0		# $s0 := -$s0
	POSITIVE:
	
	# b) move $s0, $s1
	addu $s0, $zero, $s1		# Copy content of $s1 to $s0 by adding unsigned numbers
	
	# c) not $s0, $s1
	nor $s0, $s1, $zero
	
	# d) ble $s1, $s2, label
	slt $at, $s2, $s1
	beq $at, $zero, LABEL
	addi $t3, $zero, 1	# Check if this code is skipped, $t3 = 0 -> skipped, $t3 = 1 -> not skipped
	LABEL: