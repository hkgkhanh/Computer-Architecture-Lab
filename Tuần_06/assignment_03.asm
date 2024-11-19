# Laboratory Exercise 6, Assignment 3

.data
	A: .word 12, 10, 20, 4, 1, 2, 20, 3
	
.text
main:
	la $a0,A						# $a0 = Address(A[0])
	la $a1,8						# $a1 = length of A = 8
	j bubble_sort				# bubble sort
after_sort:
	li $v0, 10 					#exit
	syscall
end_main:

bubble_sort:
	addi $t0, $zero, 0			# $t0 = i = 0
	
loop1:
	beq $t0, $a1, done_loop1		# if i == n then jump out of loop1
	add $t1, $zero, $zero		# j = 0
	j loop2
done_loop2:
	addi $t0, $t0, 1				# i += 1
	j loop1						# loop1
	
loop2:
	addi $a2, $a1, -1			# set last iteration of j
	sub $a2, $a2, $t0			# last iteration of j is n - 1 - i
	beq $t1, $a2, done_loop2		# if j == n - 1 - i then continue at loop1
	sll $s3, $t1, 2
	add $s3, $s3, $a0			# $s3 points to address of A[j]
	lw $s6, 0($s3)				# $s6 = A[j]
	addi $t2, $t1, 1				# $t2 = j + 1
	sll $s4, $t2, 2
	add $s4, $s4, $a0			# $s4 points to address of A[j + 1]
	lw $s7, 0($s4)				# $s7 = A[j + 1]
	slt $s5, $s6, $s7
	bne $s5, $zero, skip
	add $s5, $zero, $s6			# temp = A[j]
	add $s6, $zero, $s7			# A[j] = A[j+1]
	add $s7, $zero, $s5			# A[j+1] = temp
	sw $s6, 0($s3)
	sw $s7, 0($s4)
skip:
	addi $t1, $t1, 1				# j += 1
	j loop2
	
done_loop1:
	j after_sort
	
# Code in C:
# void BubbleSort(int a[], int n)
# {
#    int temp;
#    for (int i = 0; i < n; i++)
#    {
#		for (int j = 0; j < n - 1 - i; j++)
#		{
#			if (a[j] > a[j+1])
#			{
#                temp = a[j];
#                a[j] = a[j+1];
#                a[j+1] = temp;
#			}
#		}
#	 }
# }