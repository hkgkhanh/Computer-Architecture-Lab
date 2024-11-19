# Laboratory Exercise 3, Home Assignment 1, Assignment 1

.text
	addi $s1, $zero, 2			# i = 2
	addi $s2, $zero, 1			# j = 1
	start:
		slt $t0, $s2, $s1		# j < i
		bne $t0, $zero, else		# branch to else if j < i
		addi $t1, $t1, 1			# then part: x = x + 1
		addi $t3, $zero, 1		# z = 1
		j endif					# skip else part
	else:
		addi $t2, $t2, -1		# begin else part: y = y - 1
		add $t3, $t3, $t3		# z = z * 2
	endif:
	
# Chạy từng lệnh
# Lệnh 1 (dòng 4): Gán $s1 = i = 2
# Lệnh 2 (dòng 5): Gán $s2 = j = 1
# Lệnh 3 (dòng 7): So sánh $s2 và $s1, nếu $s2 < $s1 thì gán $t0 = 1, không thì gán $t0 = 0. Do $s2 < $s1 (1 < 2) nên $t0 = 1
# Lệnh 4 (dòng 8): So sánh $t0 với $zero, nếu $t0 != 0 thì nhảy đến nhãn else, nếu $t0 == 0 thì tiếp tục chạy chương trình
# Ở đây $t0 != 0 nên nhảy đến nhãn else, lệnh tiếp theo được thực hiện là lệnh 8 (dòng 13)
# Lệnh 8 (dòng 13): Tính $t2 = $t2 - 1 = 0 - 1 = -1
# Lệnh 9 (dòng 14): Tính $t3 = 2 * $t3 = 2 * 0 = 0