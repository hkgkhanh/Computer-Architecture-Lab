# Laboratory Exercise 3, Home Assignment 3, Assignment 3

.data
	test: .word 1
	
.text
	addi $s2, $zero, 0		# a = 0
	addi $s3, $zero, 1		# b = 1
	la $s0, test				# load the address of test variable to $s0
	lw $s1, 0($s0)			# load the value of test to $s1
	li $t0, 0				# load the value for test case
	li $t1, 1
	li $t2, 2
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	j default
	
	case_0:
		addi $s2, $s2, 1		# a += 1
		j continue
	case_1:
		sub $s2, $s2, $t1	# a -= 1
		j continue
	case_2:
		add $s3, $s3, $s3	# b = b * 2
		j continue
		
	default:
	continue:
	
# Chạy từng lệnh:
# Lệnh 1, 2 (dòng 7, 8): Khởi tạo a = 0, b = 1
# Lệnh 3,4 (dòng 9): Nạp địa chỉ của biến test vào thanh ghi $s0
# Lệnh 5 (dòng 10): Nạp giá trị của test (giá trị của thanh ghi $s0) vào $s1
# Lệnh 6, 7, 8 (dòng 11, 12, 13): Nạp giá trị của các test case, lần lượt là 0, 1, 2
# Lệnh 9, 10, 11 (dòng 14, 15, 16): So sánh giá trị của $s1 với từng test case
#	Nếu $s1 == $t0 (== 0) thì nhảy đến nhãn case_0
#	Nếu $s1 == $t1 (== 1) thì nhảy đến nhãn case_1
#	Nếu $s1 == $t2 (== 2) thì nhảy đến nhãn case_2
# Vì test có giá trị khởi tạo là 1 nên $s1 = 1 == $t1 nên nhảy đến nhãn case_1
# Chương trình tiếp tục thực hiện lệnh 15 (dòng 23): Tính $s2 -= $t1 tức a -= 1 => a = -1 
# Lệnh 16 (dòng 24): Nhảy đến nhãn continue.
# Kết quả thực hiện chương trình: a = -1, b = 1

# Thử với test = 0:
# Kết quả a = 1, b = 1

# Thử với test = 2:
# Kết quả a = 0, b = 2

# Thử với test = 3:
# Kết quả a = 0, b = 1