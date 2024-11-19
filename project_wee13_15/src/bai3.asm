# Nhóm 2, Final Project, Bài 3 (bài tự chọn)
# Viết chương trình tìm số lớn nhất của một mảng A gồm N số nguyên theo
# phương pháp đệ quy. Với N = 1, số lớn nhất chính là số nguyên duy nhất của
# mảng A[1]. Nếu N > 1, số lớn nhất hoặc là A[N] hoặc là số lớn nhất trong các số
# A[1]...A[N-1].

.data
	A: .word    # khai báo mảng A
	input_N_prompt: .asciiz "Input number of integers: N = "
	input_Ai_prompt: .asciiz "Input A["
	input_Ai_end_prompt: .asciiz "] = "
	result_prompt: .asciiz "Maximum value in the array is "
	result_index_prompt: .asciiz ", at index "
	
.text
main:
	la $s0, A                # $s0 trỏ tới mảng A
	
	###### NHẬP N #####
	li $v0, 4                # code 4 để xuất string
	la $a0, input_N_prompt
	syscall
	
	li $v0, 5                # code 5 để nhập integer
	syscall
	
	add $s2, $zero, $v0      # $s2 chứa lưu số phần tử của mảng A
	
	##### NHẬP MẢNG A #####
	addi $t0, $zero, 0       # khởi tạo biến đếm vòng lặp
input_loop:
	beq $t0, $s2, end_input  # nếu i == N thì kết thúc vòng lặp
	
	li $v0, 4                # code 4 để xuất string "Input A["
	la $a0, input_Ai_prompt
	syscall
	
	li $v0, 1                # code 1 để xuất integer chỉ số i
	add $a0, $zero, $t0
	syscall
	
	li $v0, 4                # code 4 để xuất string "] = "
	la $a0, input_Ai_end_prompt
	syscall
	
	li $v0, 5                # code 5 để nhập integer
	syscall
	
	sll $t1, $t0, 2          # ($t1) = i * 4
	add $t1, $s0, $t1        # $t1 trỏ đến A[i]
	sw $v0, 0($t1)           # lưu giá trị vừa nhập vào A[i]
	
	addi $t0, $t0, 1         # i += 1
	j input_loop             # lặp
	
end_input:	
	#### THỰC HIỆN TÌM MAX ###
	addi $s2, $s2, -1        # phần tử cuối cùng là A[N - 1]
	add $a0, $s2, $zero      # truyền tham số đầu vào là N
	jal FIND_MAX             # gọi hàm FIND_MAX
	move $s1, $v0            # lưu giá trị max vào $s1
	move $s3, $v1            # lưu vị trí của giá trị max vào $s3
	
	li $v0, 4                # code 4 để xuất string thông báo số max
	la $a0, result_prompt
	syscall
	
	li $v0, 1                # code 1 để xuất integer
	move $a0, $s1            # nạp giá trị max vào $a0
	syscall
	
	li $v0, 4                # code 4 để xuất string thông báo vị trí max
	la $a0, result_index_prompt
	syscall
	
	li $v0, 1                # code 1 để xuất integer
	move $a0, $s3            # nạp vị trí của giá trị max vào $a0
	syscall
	j end_program

#---------------------------------------------------------------------
# Procedure FIND_MAX: tìm phần tử lớn nhất của mảng A
# param[in] $a0 số phần tử của mảng A trừ 1
# param[out] $v0 phần tử lớn nhất
# param[out] $v1 vị trí của phần tử lớn nhất
#---------------------------------------------------------------------
FIND_MAX:
	addi $sp, $sp, -8        # tạo khoảng trống trên stack
	sw $ra, 0($sp)           # lưu địa chỉ trả về
	sw $a0, 4($sp)           # lưu $a0
	
	slti $t0, $a0, 1         # $t0 := ($a0 < 1) ? 1 : 0
	beq $t0, $zero, recursion
	
	# bước đệ quy cơ sở N = 0
	addi $t1, $s0, 0         # $t1 trỏ tới A[0]
	lw $v0, 0($t1)           # max := A[0]
	addi $v1, $zero, 0       # index := 0
	j done
	
recursion:
	addi $a0, $a0, -1        # N := N - 1
	jal FIND_MAX             # gọi đệ quy FIND_MAX(N - 1)
	
	lw $a0, 4($sp)           # khôi phục giá trị $a0 từ stack

	sll $t1, $a0, 2          # $t1 := N * 4
	add $t1, $s0, $t1        # $t1 trỏ tới A[N]
	lw $t2, 0($t1)           # nạp A[N] vào $t2
	
	# So sánh $v0 (max của A[1]...A[N-1]) với A[N]
	slt $t3, $v0, $t2        # $t3 := $v0 < $t2 ? 1 : 0 (tức là max < A[N])
	beq $t3, $zero, done
	
	# Cập nhật lại max
	move $v0, $t2            # max := A[N]
	move $v1, $a0            # index := N
	
done:
	lw $ra, 0($sp)           # khôi phục địa chỉ trả về
	addi $sp, $sp, 8         # giải phóng khoảng trống trên stack
	jr $ra                   # trả về
	
end_program:
	li $v0, 10               # code 10 để kết thúc chương trình
	syscall