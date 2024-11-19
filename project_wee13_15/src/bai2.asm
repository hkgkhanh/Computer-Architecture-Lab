.data
	prompt1: .asciiz "Enter the first number: a = "
	prompt2: .asciiz "Enter the second number: b = "
	result1: .asciiz "a + b = "
	result2: .asciiz "a - b = "
	result3: .asciiz "a * b = "
	result4: .asciiz "a / b = "
	error_add_overflow: .asciiz "Error in addition: Number overflow\n"
	error_add_underflow: .asciiz "Error in addition: Number underflow\n"
	error_sub_overflow: .asciiz "Error in subtraction: Number overflow\n"
	error_sub_underflow: .asciiz "Error in subtraction: Number underflow\n"
	error_mul_overflow: .asciiz "Error in multiplication: Number overflow\n"
	error_mul_underflow: .asciiz "Error in multiplication: Number underflow\n"
	error_div_overflow: .asciiz "Error in division: Number overflow\n"
	error_div_underflow: .asciiz "Error in division: Number underflow\n"
	div_nan: .asciiz "a / b = NaN\n"
	new_line: .asciiz "\n"

.text
main:
	li $v0, 4                   # code 4 để xuất string
	la $a0, prompt1             # thông báo nhập a
	syscall
	
	li $v0, 6                   # code 6 để đọc số float
	syscall
	
	mfc1 $s0, $f0               # ($s0) = a
	
	li $v0, 4                   # code 4 để xuất string
	la $a0, prompt2             # thông báo nhập b
	syscall
	
	li $v0, 6                   # code 6 để đọc số float
	syscall
	
	mfc1 $s1, $f0               # ($s1) = b

	li $t9,1                    # $t9 để biết đang thực hiện phép cộng hay trừ
	addi $k1,$zero,0x80000000

#############################################
#############################################
# CỘNG
add_float:
	xor $s2,$s0,$s1
	li $a1,0
	beq $s2,$k1,ans
	beq $s0, $zero, zero_a # nếu a = 0 thì result = b
	beq $s0, $k1, zero_a  # nếu a = -0 thì result = b
	beq $s1, $zero, zero_b # nếu b = 0 thì result = a
	beq $s1, $k1, zero_b # nếu b = -0 thì result = a

	j out_zero_a_b

zero_a: 
	move $a1,$s1
	j ans
zero_b:
	move $a1,$s0
	j ans
out_zero_a_b:
	andi $t1, $s0, 0x80000000 # bit dấu
	srl $t1,$t1,31
	andi $t4, $s1, 0x80000000 # bit dấu
	srl $t4,$t4,31


	andi $t2,$s0,0x7f800000 # bit mũ E1
	andi $t5,$s1,0x7f800000 # bit mũ E2	

	andi $t3,$s0,0x007fffff # bit định trị X
	ori $t3,$t3,0x00800000  # sửa bit thêm 1 vào trước 23 bit định trị
	sll $t3,$t3,8     	# dịch định trị của X sang trái 8 bit # có dạng: 1.XXXXX...
			
	andi $t6,$s1,0x007fffff # bit định trị Y
	ori $t6,$t6,0x00800000  # sửa bit thêm 1 vào trước 23 bit định trị
	sll $t6,$t6,8     	# dịch định trị của Y sang trái 8 bit có dạng 1.YYYYYY


# $t8 so sánh E1 với E2 xem thằng nào lớn hơn.
     srl $t2,$t2,23
     srl $t5,$t5,23
     subu $t8,$t2,$t5 # $t8 = E1-E2
     sll $t2,$t2,23
     sll $t5,$t5,23
     bltz $t8,less
     bgtz $t8,greater
     j equal	
# nếu E1<E2 thì :
less:
# nâng E1 lên bằng E2 và dịch bit định trị
     mul $t8,$t8,-1 # abs(E1-E2)
     add $t2,$t5,$zero # E1=E2
     srlv $t3,$t3,$t8 # dịch phải 1.XXXX 1 khoảng =abs(E1-E2) bit
     j equal
#nếu E1>E2
greater:
# nâng E2 lên bằng E1 và dịch bit định trị
     add $t5,$t2,$zero # E2=E1
     srlv $t6,$t6,$t8 # dịch phải 1.YYYY... 1 khoảng = abs(E1-E2) bit

equal:
# nếu E1=E2:
     srl $t3,$t3,2
     srl $t6,$t6,2
# bit dấu result =$t7
# thực hiện phép cộng : 00X.XXXX và 00Y.YYYYY = ZZZ.ZZZZ
# nếu X là số âm thì lấy bù 2
# nếu Y là số âm thì lấy bù 2
chk_negaX:
	bne $t1,1,chk_negaY
bu2_X:	
	mul $t3,$t3,-1	
chk_negaY:
	bne $t4,1,add_XY
bu2_Y:
	mul $t6,$t6,-1	
	
add_XY:
	add $a1,$t3,$t6
	srl $t2,$t2,23
	
# chuẩn hóa kết quả:
	andi $t7,$a1,0x80000000 # bit dấu  
	beq $t7,0x80000000,bu2
	j out_bu2
# nếu bit đầu tiên là 1 => bit dấu của result là âm -> cần bù 2:
bu2:
 	mul $a1,$a1,-1

out_bu2:
	sll $a1,$a1,1
	# chọn E1 đại diện cho E
	# $t8 là biến duyệt
	# ZZ.ZZZZZZ * 2^E
	andi $t8,$a1,0x80000000
	beq $t8,0x80000000,form1z
		
# nếu là 0Z.ZZZZZ.. thì dịch thành Z.ZZZZ và E giữ nguyên:
form0z:
	 #0000 0000 1000 = 0x00800000
loop:
	sll $a1,$a1,1
	# Z.ZZZZZ * 2^E
	andi $t8,$a1,0x80000000
	# xét nếu Z =1 thì trả kết quả luôn 
	beq $t8,0x80000000,result_add
	# nếu Z=0 thì E=E-1 và loop tiếp  
	sub $t2,$t2,1 # E=E-1
	j loop
# nếu là 1Z.ZZZZ.. thì dịch 1.ZZZZ và E=E+1 và trả kết quả luôn
form1z:	
	add $t2,$t2,1 # E=E+1

# check tràn số mũ
	blt $t2,0,result_add_sub_underflow # tràn dưới
	bgt $t2,255,result_add_sub_overflow # tràn trên
result_add:

sll $t2,$t2,23
# $t2 = 0 8 bit E 00000
# $a1 = 1.ZZZZZZZ -> cần tách lấy 23 bit ZZZZZZ
	sll $a1,$a1,1
	srl $a1,$a1,9
# $a1= 0 00000000 23bit định trị
# $t7 = 1 bit dấu  S000000000

# ghép vào
	or $a1,$a1,$t2
	or $a1,$a1,$t7

ans: 
	beq $t9,1,print_add
	beq $t9,2,print_sub
	
print_add:
	mtc1 $a1, $f0 # chuyển giá trị của $a1 sang $f0
	
	li $v0, 4 # code 4 để xuất string
	la $a0, result1 # thông báo a + b
	syscall
	
	li $v0, 2 # code 2 để xuất số float
	mov.s $f12, $f0 # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
    # in ký tự xuống dòng
    li $v0, 4          
    la $a0, new_line  
    syscall          

sub_float:
	# chuyển Y thành -Y . X - Y = X + (-Y) bằng cách đổi dấu bit đầu
	li $t9,2 # 1 để biết là phép -
	xor $s1,$s1,$k1 # đổi dấu bit dấu của Y
	j add_float

print_sub:
	mtc1 $a1, $f0 # chuyển giá trị của $a1 sang $f0
	
	li $v0, 4 # code 4 để xuất string
	la $a0, result2 # thông báo a - b
	syscall
	
	li $v0, 2 # code 2 để xuất số float
	mov.s $f12, $f0 # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
	# in ký tự xuống dòng
    li $v0, 4          
    la $a0, new_line  
    syscall  
	
	# chuyển lại -b thành b
	xor $s1,$s1,$k1             # đổi lại dấu bit dấu của b về ban đầu
	j mul_float
	
result_add_sub_overflow:
	beq $t9, 1, result_add_overflow
	beq $t9, 2, result_sub_overflow
	
result_add_sub_underflow:
	beq $t9, 1, result_add_underflow
	beq $t9, 2, result_sub_underflow
	
result_add_overflow:
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_add_overflow            # thông báo tràn trên số mũ
	syscall
	
	j sub_float
	
result_sub_overflow:
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_sub_overflow            # thông báo tràn trên số mũ
	syscall
	
	j mul_float
	
result_add_underflow:
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_add_underflow           # thông báo tràn dưới số mũ
	syscall
	
	j sub_float
	
result_sub_underflow:
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_sub_underflow           # thông báo tràn dưới số mũ
	syscall
	
	j mul_float
#############################################
#############################################
# NHÂN
mul_float:
	addi $t0, $zero, 0x80000000           # ($t0) = -0
	beq $s0, $zero, result_zero_mul       # nếu a = +0 thì result = 0
	beq $s1, $zero, result_zero_mul       # nếu b = +0 thì result = 0
	beq $s0, $t0, result_zero_mul         # nếu a = -0 thì result = 0
	beq $s1, $t0, result_zero_mul         # nếu b = -0 thì result = 0
	
	# tách lấy phần định trị của cả hai số, nằm trong 23 bit thấp
	andi $t0, $s0, 0x007FFFFF             # phần định trị của a
	andi $t1, $s1, 0x007FFFFF             # phần định trị của b
    
	# thêm bit ngầm định ở vị trí 24 (là số 1 đứng trước dấu chấm)
	ori $t0, $t0, 0x00800000              # thêm bit ngầm định vào phần định trị của a
	ori $t1, $t1, 0x00800000              # thêm bit ngầm định vào phần định trị của b
    
    # dịch trái để bit đầu là bit 1 trước dấu chấm
	sll $t0, $t0, 8
	sll $t1, $t1, 8
    
    # nhân phần định trị
	multu $t0, $t1
	#mflo $t3                             # lấy 32 bit thấp từ thanh ghi LO
	mfhi $t2                              # lấy 32 bit cao từ thanh ghi HI
	
	# lúc này ($t2) = 01.xx xxxx ... (TH1) hoặc 10.xx xxxx ... (TH2)
	# nhận thấy rằng không xảy ra TH 11.xx... hoặc 00.xx...
	bgez $t2, zero_one_mul                # (TH1)
	j one_zero_mul                        # (TH2)
	
zero_one_mul:
	sll $t2, $t2, 1                       # dịch trái để đưa bit 1 lên đầu
	addi $t5, $zero, 0                    # giữ nguyên phần mũ
	j combine_mul
	
one_zero_mul:
	addi $t5, $zero, 1                    # giữ nguyên phần định trị và tăng phần mũ
	
combine_mul:
	# lấy phần mũ của a và b
	srl $t3, $s0, 23
	andi $t3, $t3, 0xFF                   # lấy phần mũ của a
	srl $t4, $s1, 23
	andi $t4, $t4, 0xFF                   # lấy phần mũ của b

	# cộng phần mũ và trừ đi 127, chú ý ở thời điểm này ($t5) = 0 hoặc 1
	add $t5, $t5, $t3
	add $t5, $t5, $t4
	addi $t5, $t5, -127
    
	# xử lí tràn số mũ
	li $t6, 255
	li $t7, 0
	bgt $t5, $t6, result_overflow_mul     # tràn trên số mũ
	blt $t5, $t7, result_underflow_mul    # tràn dưới số mũ
	
	# kết hợp phần định trị với phần mũ
	srl $t2, $t2, 8                       # dịch phần định trị về vị trí của nó
	andi $t2, $t2, 0x007FFFFF             # loại bỏ bit 1 trước dấu chấm
	sll $t5, $t5, 23                      # dịch phần mũ về vị trí của nó
	or $t2, $t2, $t5                      # kết hợp phần định trị và phần mũ
    
	# xử lí dấu âm
	andi $t5, $s0, 0x80000000             # lấy dấu của a
	andi $t6, $s1, 0x80000000             # lấy dấu của b
	xor $t5, $t5, $t6                     # bit đầu giống nhau thì là 0, không thì 1
	andi $t5, $t5, 0x80000000             # đặt lại các bit khác thành 0
	or $t2, $t2, $t5                      # đặt bit đầu và kết quả
    
	# xuất kết quả ra console
	mtc1 $t2, $f0                         # chuyển giá trị của $t2 sang $f0
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, result3                       # thông báo a * b
	syscall
	
	li $v0, 2                             # code 2 để xuất số float
	mov.s $f12, $f0                       # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, new_line                      # xuống dòng
	syscall
	
	j div_float
	
result_zero_mul:
	add $s2, $zero, $zero                 # ($s2) = a * b = 0
	mtc1 $s2, $f0                         # chuyển giá trị của $s2 sang $f0
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, result3                       # thông báo a * b
	syscall
	
	li $v0, 2                             # code 2 để xuất số float
	mov.s $f12, $f0                       # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, new_line                      # xuống dòng
	syscall
	
	j div_float

# về phần xử lí tràn số:
# trong slide lớp lí thuyết có nhắc đến 4 loại tràn:
# tràn trên/dưới số mũ và tràn trên/dưới phần định trị
# cách xử lí phần định trị của bài này đã xử lí được tràn phần định trị
# nên bài này chỉ phải xử lí tràn số mũ

result_overflow_mul:	
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_mul_overflow            # thông báo tràn trên số mũ
	syscall
	
	j div_float
	
result_underflow_mul:	
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_mul_underflow           # thông báo tràn dưới số mũ
	syscall
	
	j div_float


#############################################
#############################################
# CHIA
div_float:
	addi $t0, $zero, 0x80000000           # ($t0) = -0
	beq $s0, $zero, a_is_zero_div
	beq $s0, $t0, a_is_zero_div           # xét trường hợp a = +0 hoặc -0
	
	# giờ chỉ còn trường hợp a != 0
	beq $s1, $zero, b_is_zero_div         # nếu b = +0 thì nhảy đến trường hợp b = 0
	beq $s1, $t0, b_is_zero_div           # nếu b = -0 thì nhảy đến trường hợp b = 0
	
	# giờ chỉ còn trường hợp a và b đều khác 0
	# tách lấy phần định trị của cả hai số, nằm trong 23 bit thấp
	andi $t0, $s0, 0x007FFFFF             # phần định trị của a
	andi $t1, $s1, 0x007FFFFF             # phần định trị của b
    
	# thêm bit ngầm định ở vị trí 24 (là số 1 đứng trước dấu chấm)
	ori $t0, $t0, 0x00800000              # thêm bit ngầm định vào phần định trị của a
	ori $t1, $t1, 0x00800000              # thêm bit ngầm định vào phần định trị của b
    
	# dịch trái để bit đầu là bit 1 trước dấu chấm
	sll $t0, $t0, 8
	sll $t1, $t1, 8
	addi $t5, $zero, 0

	addi $t2, $zero, 0                    # quotient
	add $t3, $zero, $t0                   # remainder := dividend
	addi $t4, $zero, 32                   # số lần lặp
	
loop_div:
	beqz $t4, out_loop_div                # nếu bộ đếm = 0 thì thoát khỏi lặp
	
	subu $t3, $t3, $t1                    # remainder -= divisor
	
	bltz $t3, else_div                    # trường hợp remainder < 0
	# trường hợp remainder >= 0
	sll $t2, $t2, 1                       # dịch trái quotient
	addi $t2, $t2, 1                      # bit cuối đặt là 1
	j end_else_div
	
# trường hợp remainder < 0
else_div:
	addu $t3, $t3, $t1                    # remainder += divisor
	sll $t2, $t2, 1                       # dịch trái quotient

end_else_div:
	srl $t1, $t1, 1                       # dịch phải divisor
	addi $t4, $t4, -1                     # giảm bộ đếm
	j loop_div
	
out_loop_div:


norm_loop_div:
	bltz $t2, out_norm_loop_div           # bit đầu = 0 thì kết thúc lặp
	beq $t2, $zero, out_norm_loop_div     # nếu phần định trị toàn bit 0 thì cũng kết thúc lặp
	sll $t2, $t2, 1                       # dịch trái $t2
	addi $t5, $t5, -1                     # điều chỉnh độ lệch phần mũ
	j norm_loop_div
	
out_norm_loop_div:
	#srl $t2, $t2, 8 # dịch phần định trị về đúng vị trí
	
combine_div:
	# lấy phần mũ của a và b
	srl $t3, $s0, 23
	andi $t3, $t3, 0xFF                   # lấy phần mũ của a
	srl $t4, $s1, 23
	andi $t4, $t4, 0xFF                   # lấy phần mũ của b

	# trừ phần mũ và trừ đi 127
	add $t5, $t5, $t3
	sub $t5, $t5, $t4
	addi $t5, $t5, 127
    
	# xử lí tràn số mũ
	li $t6, 255
	li $t7, 0
	bgt $t5, $t6, result_overflow_div     # tràn trên số mũ
	blt $t5, $t7, result_underflow_div    # tràn dưới số mũ
	
	# kết hợp phần định trị với phần mũ
	srl $t2, $t2, 8                       # dịch phần định trị về vị trí của nó
	andi $t2, $t2, 0x007FFFFF             # loại bỏ bit 1 trước dấu chấm
	sll $t5, $t5, 23                      # dịch phần mũ về vị trí của nó
	or $t2, $t2, $t5                      # kết hợp phần định trị và phần mũ
    
	# xử lí dấu
	andi $t5, $s0, 0x80000000             # lấy dấu của a
	andi $t6, $s1, 0x80000000             # lấy dấu của b
	xor $t5, $t5, $t6                     # bit đầu giống nhau thì 0, không thì 1
	andi $t5, $t5, 0x80000000             # đặt lại các bit khác thành 0
	or $t2, $t2, $t5                      # đặt bit đầu vào kết quả
    
	# xuất kết quả ra console
	mtc1 $t2, $f0                         # chuyển giá trị của $t2 sang $f0

	li $v0, 4                             # code 4 để xuất string
	la $a0, result4                       # thông báo a / b
	syscall
	
	li $v0, 2                             # code 2 để xuất số float
	mov.s $f12, $f0                       # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
	j end_program

# về phần xử lí tràn số: (tương tự phép nhân)
# trong slide lớp lí thuyết có nhắc đến 4 loại tràn:
# tràn trên/dưới số mũ và tràn trên/dưới phần định trị
# cách xử lí phần định trị của bài này đã xử lí được tràn phần định trị
# nên bài này chỉ phải xử lí tràn số mũ

result_overflow_div:	
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_div_overflow            # thông báo tràn trên số mũ
	syscall
	
	j end_program
	
result_underflow_div:	
	li $v0, 4                             # code 4 để xuất string
	la $a0, error_div_underflow           # thông báo tràn dưới số mũ
	syscall
	
	j end_program
	
a_is_zero_div:
	addi $t0, $zero, 0x8000000            # ($t0) = -0
	beq $s1, $zero, a_and_b_is_zero_div   # nếu b = +0 thì nhảy đến trường hợp a = b = 0
	beq $s1, $t0, a_and_b_is_zero_div     # nếu b = -0 thì nhảy đến trường hợp a = b = 0
	# còn lại là trường hợp a = 0, b != 0 nên result = 0
	add $s2, $zero, $zero                 # ($s2) = a / b = 0
	mtc1 $s2, $f0                         # chuyển giá trị của $s2 sang $f0
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, result4                       # thông báo a / b
	syscall
	
	li $v0, 2                             # code 2 để xuất số float
	mov.s $f12, $f0                       # chuyển giá trị kết quả sang $f12 để xuất
	syscall
	
	j end_program
	
a_and_b_is_zero_div:
	li $v0, 4                             # code 4 để xuất string
	la $a0, div_nan                       # thông báo phép chia 0/0
	syscall
	
	j end_program
	
b_is_zero_div:
	xor $s2, $s0, $s1                     # lấy bit đầu = 0 nếu 2 bit đầu giống nhau, không thì = 1
	andi $s2, $s2, 0x80000000             # đặt mọi bit sau bit đầu là 0
	ori $s2, $s2, 0x7F800000              # ($s2) = x111 1111 1000 0000 0000 0000 0000 0000, x = 0 hoặc 1
	
	mtc1 $s2, $f0                         # chuyển giá trị của $s2 sang $f0
	
	li $v0, 4                             # code 4 để xuất string
	la $a0, result4                       # thông báo a / b
	syscall
	
	li $v0, 2                             # code 2 để xuất số float
	mov.s $f12, $f0                       # chuyển giá trị kết quả sang $f12 để xuất
	syscall

	j end_program

end_program:
	li $v0, 10                            # code 10 để exit
	syscall
