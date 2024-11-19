# Laboratory Exercise 3, Assignment 5b

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
		# beq $t2, $zero, endloop	# if $t2 == 0 (i < n) then jump to endloop
		# beq $s1, $s3, endloop	# if i == n then jump to endloop
		add $t1, $s1, $s1		# $t1 = 2 * $s1
		add $t1, $t1, $t1		# $t1 = 4 * $s1
		add $t1, $t1, $s2		# $t1 store address of A[i]
		lw 	$t0, 0($t1)			# load value of A[i] in $t0
		add $s5, $s5, $t0		# sum += A[i]
		add $s1, $s1, $s4		# i += step
		slt $t2, $s1, $s3		# $t2 = i < n ? 1 : 0
		beq $t2, $zero, endloop	# if $t2 == 0 (i < n) then jump to endloop
		beq $s1, $s3, endloop	# if i == n then jump to endloop
		j loop					# go to loop
	endloop:
	
# Modification: thêm lệnh so sánh i == n, nếu đúng thì nhảy đến nhãn endloop.
# Lúc này, có 2 trường hợp để nhảy đến endloop, đó là i < n và i == n, tức i <= n.