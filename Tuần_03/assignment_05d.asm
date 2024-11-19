# Laboratory Exercise 3, Assignment 5d

.data
	A: .word 3,2,7
	
.text
	addi $s5, $zero, 0			# sum = 0
	addi $s1, $zero, 0			# i = 0
	addi $s3, $zero, 3			# n = 3
	addi $s4, $zero, 1			# step = 1
	la $s2, A					# load the address of A[0]

	loop:
		# slt $t2, $s1, $s3		# $t2 = i < n ? 1 : 0
		# beq $t2, $zero, endloop	# if $t2 == 0 then jump to endloop
		add $t1, $s1, $s1		# $t1 = 2 * $s1
		add $t1, $t1, $t1		# $t1 = 4 * $s1
		add $t1, $t1, $s2		# $t1 store address of A[i]
		lw 	$t0, 0($t1)			# load value of A[i] in $t0
		add $s5, $s5, $t0		# sum += A[i]
		add $s1, $s1, $s4		# i += step
		beq $t0, $zero, endloop	# if A[i] == 0 then jump to endloop (ở đây A[i] thực chất vẫn có giá trị của vòng lặp hiện tại do biến i đã tăng nhưng thanh ghi $t0 vẫn chưa trỏ đến phần từ tiếp theo)
		j loop
	endloop: