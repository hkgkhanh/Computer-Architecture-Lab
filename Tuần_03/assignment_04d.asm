# Laboratory Exercise 3, Home Assignment 1, Assignment 1

.text
	addi $s1, $zero, 2			# i = 2
	addi $s2, $zero, 1			# j = 1
	addi $s3, $zero, 3			# m = 3
	addi $s4, $zero, 1			# n = 1
	start:
		add $t4, $s1, $s2		# $t4 = i + j
		add $t5, $s3, $s4		# $t5 = m + n
		slt $t0, $s5, $s4		# m + n < i + j
		bne $t0, $zero, else		# branch to else if m + n < i + j
		addi $t1, $t1, 1			# then part: x = x + 1
		addi $t3, $zero, 1		# z = 1
		j endif					# skip else part
	else:
		addi $t2, $t2, -1		# begin else part: y = y - 1
		add $t3, $t3, $t3		# z = z * 2
	endif:
	
# Modification: Thêm biến m, n, tính tổng i + j và m + n sau đó so sánh 2 tổng này
