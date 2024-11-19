# Laboratory Exercise 3, Home Assignment 1, Assignment 1

.text
	addi $s1, $zero, 2			# i = 2
	addi $s2, $zero, 1			# j = 1
	start:
		add $t4, $s2, $s1		# $t4 = i + j
		slt $t0, $zero, $t4		# compare 0 < $t4 and save result to $t0
		addi $t5, $zero, 1		# lưu giá trị 1
		sub $t6, $t5, $t4		# $t6 = 1 - $t4 là giá trị đảo của phép logic $t4 > 0, chính là i + j <= 0
		bne $t6, $zero, else		# branch to else if j < i
		addi $t1, $t1, 1			# then part: x = x + 1
		addi $t3, $zero, 1		# z = 1
		j endif					# skip else part
	else:
		addi $t2, $t2, -1		# begin else part: y = y - 1
		add $t3, $t3, $t3		# z = z * 2
	endif:
	
# Modification: Thêm 1 biến lưu ở thanh ghi $t4 là giá trị i + j, sau đó so sánh với 0