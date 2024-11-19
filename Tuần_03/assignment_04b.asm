# Laboratory Exercise 3, Assignment 4a

.text
	addi $s1, $zero, 2			# i = 2
	addi $s2, $zero, 1			# j = 1
	start:
		slt $t0, $s1, $s2		# i < j
		addi $t5, $zero, 1		# lưu giá trị 1
		sub $t4, $t5, $t0		# $t4 = 1 - $t0 là giá trị đảo của phép logic i < j, chính là i >= j 
		bne $t4, $zero, else		# branch to else if i >= j
		addi $t1, $t1, 1			# then part: x = x + 1
		addi $t3, $zero, 1		# z = 1
		j endif					# skip else part
	else:
		addi $t2, $t2, -1		# begin else part: y = y - 1
		add $t3, $t3, $t3		# z = z * 2
	endif:
	
# Modification: sửa lại dòng 7 thành slt $t0, $s1, $s2 để so sánh i < j
# Thêm 1 thanh ghi $t4 để lưu giữ giá trị đảo của $t0, đó là giá trị khi so sánh i >= j