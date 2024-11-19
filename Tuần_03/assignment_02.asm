# Laboratory Exercise 3, Home Assignment 2, Assignment 3

.data
	A: .word 3,2,7
	
.text
	addi $s5, $zero, 0			# sum = 0
	addi $s1, $zero, 0			# i = 0
	addi $s3, $zero, 3			# n = 3
	addi $s4, $zero, 1			# step = 1
	la $s2, A					# load the address of A[0]

	loop:
		slt $t2, $s1, $s3		# $t2 = i < n ? 1 : 0
		beq $t2, $zero, endloop	# if $t2 == 0 then jump to endloop
		add $t1, $s1, $s1		# $t1 = 2 * $s1
		add $t1, $t1, $t1		# $t1 = 4 * $s1
		add $t1, $t1, $s2		# $t1 store address of A[i]
		lw 	$t0, 0($t1)			# load value of A[i] in $t0
		add $s5, $s5, $t0		# sum += A[i]
		add $s1, $s1, $s4		# i += step
		j loop					# go to loop
	endloop:
	
# Chạy từng lệnh
# Lệnh 1 (dòng 7): Gán $s5 = sum = 0
# Lệnh 2 (dòng 8): Gán $s1 = i = 0
# Lệnh 3 (dòng 9): Gán $s3 = n = 3
# Lệnh 4 (dòng 10): Gán $s4 = step = 1
# Lệnh 5, 6 (dòng 11): Nạp địa chỉ của biến A[0] vào thanh ghi $s2
# Lệnh 7 (dòng 14): So sánh $s1 và $s3, nếu $s1 < $s3 thì gán $t2 = 1, ngược lại gán $t2 = 0
# Lệnh 8 (dòng 15): So sánh $t2 và $zero, nếu $t2 == 0 thì nhảy đến nhãn endloop, không thì tiếp tục
# Vì $t2 == 1 != 0 nên lệnh tiếp theo được thực hiện là lệnh 9 (dòng 16)
# Lệnh 9, 10 (dòng 16, 17): Gán $t1 = 4 * i = 4 * 0 = 0
# Lệnh 11 (dòng 18): Thanh ghi $t1 trỏ đến thanh ghi chứa biến A[i] tức A[0]
# Lệnh 12 (dòng 19): Nạp giá trị A[0] vào $t0
# Lệnh 13 (dòng 20): Tính sum += A[0] => sum = 0 + 3 = 3
# Lệnh 14 (dòng 21): Cập nhật giá trị i += step => i = 0 + 1 = 1
# Lệnh 15 (dòng 22): Nhảy về nhãn loop
# Chương trình tiếp tục thực hiện từ lệnh ở dòng 14, đến khi $s1 = 3 == n thì $t2 = 0
# Khi đó thực hiện lệnh ở dòng 15, $t2 == $zero nên nhảy đến nhãn endloop.
