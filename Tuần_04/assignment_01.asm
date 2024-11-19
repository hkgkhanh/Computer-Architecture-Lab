# Laboratory Exercise 4, Home Assignment 1, Assignment 1
.text
START:
	addi $s1, $zero, 0x7fffffff
	addi $s2, $zero, 0x731234ff
	li $t0, 0 					# No Overflow is default status
	addu $s3, $s1, $s2 			# $s3 = $s1 + $s2
	xor $t1, $s1, $s2 			# Test if $s1 and $s2 have the same sign
	bltz $t1, EXIT			 	# If not, exit
	slt $t2, $s3, $s1
	bltz $s1, NEGATIVE 			# Test if $s1 and $s2 is negative?
	beq $t2, $zero, EXIT 		# $s1 and $s2 are positive
 								# If $s3 > $s1 then the result is not overflow
	j OVERFLOW
NEGATIVE:
	bne $t2, $zero, EXIT 		# $s1 and $s2 are negative
 								# if $s3 < $s1 then the result is not overflow
OVERFLOW:
	li $t0, 1 					#the result is overflow
EXIT:

# Em viet giai thich bang tieng Anh vi bi loi font
# MEMORY AND REGISTER VALUE OBSERVATION
# Initialized $s1 = 0x7fffffff, $s2 = 0x731234ff -> there should be overflow
# After code in line 7 is executed: $s3 = 0xf31234fe
# After code in line 8 is executed: $t1 = 0x0cedcb00
# Line 9: Since $t1 > 0, the program don't jump to EXIT
# Afer code in line 10 is executed: $t2 = 1
# Line 11: Since $s1 > 0, the program don't jump to NEGATIVE
# Line 12: Since $t2 = 1 != 0, the program don't jump to EXIT
# After code in line 19 is executed: $t0 = 1 as the result is overflow
