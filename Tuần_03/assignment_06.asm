# Laboratory Exercise 3, Assignment 6

.data
	A: .word 4, -3, 2
	
.text
	addi $s1, $zero, 0			# max_abs := 0
	addi $s2, $zero, 0			# i := 0
	addi $s3, $zero, 4			# n := 4
	la $s4, A					# load the address of A[0]
	
	loop:
		slt $t2, $s2, $s3				# $t2 := i < n ? 1 : 0
		beq $t2, $zero, endloop			# if $t2 == 0 (i >= n) then jump to endloop
		add $t1, $s2, $s2				# $t1 := 2 * $s2
		add $t1, $t1, $t1				# $t1 := 4 * $s2
		add $t1, $t1, $s4				# $t1 store address of A[i]
		lw 	$t0, 0($t1)					# load value of A[i] in $t0
		slt $t3, $t0, $zero				# $t3 := A[i] < 0 ? 1 : 0
		bne $t3, $zero, ifneg			# if $t3 == 1 then jump to ifneg
		j continuewithpos
		
		continuewithpos:
			slt $t4, $s1, $t0			# $t4 := max_abs < A[i] ? 1 : 0
			bne $t4, $zero, assignnew	# if max_abs < A[i] then jump to assignnew
			add $s2, $s2, 1				# i += step
			j loop						# jump back to loop
		
		assignnew:
			add $s1, $zero, $t0			# max_abs := A[i]
			add $s2, $s2, 1				# i += step
			j loop
			
		ifneg:
			sub $t0, $zero, $t0			# A[i] := -A[i]
			j continuewithpos
	endloop: