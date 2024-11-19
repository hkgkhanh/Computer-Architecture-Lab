# Laboratory Exercise 6, Assignment 4

.data
	A: .word 12, 10, 20, 4, 1, 2, 20, 3
	
.text
main:
	la $a0,A						# $a0 = Address(A[0])
	la $a1,8						# $a1 = length of A = 8
	j insertion_sort				# insertion sort
after_sort:
	li $v0, 10 					#exit
	syscall
end_main:

insertion_sort:
	addi $t0, $zero, 1			# $t0 = i = 1
for_loop:
	beq $t0, $a1, done_for		# if i == n then jump out of for loop
	addi $t1, $t0, -1			# j = i - 1
	sll $s0, $t0, 2				# $s0 = 4*i
	add $s0, $s0, $a0			# $s0 = address of A[i]
	lw $s0, 0($s0)				# $s0 = A[i]
	add $t2, $s0, $zero			# $t2 = key = A[i]
	
while_loop:
	slt $s1, $t1, $zero
	bne $s1, $zero, end_while	# if j < 0 then jump out of while loop
	sll $s0, $t1, 2				# $s0 = 4*j
	add $s0, $s0, $a0			# $s0 = address of A[j]
	lw $s0, 0($s0)				# $s0 = A[j]
	slt $s1, $s0, $t2
	bne $s1, $zero, end_while	# if A[j] < key then jump out of while loop
	beq $s0, $t2, end_while		# if A[j] == key then jump out of while loop
	addi $t3, $t1, 1				# $t3 = j + 1
	sll $s2, $t3, 2				# $s2 = 4*(j+1)
	add $s2, $s2, $a0			# $s2 = address of A[j+1]
	sw $s0, 0($s2)				# A[j+1] = A[j]
	addi $t1, $t1, -1			# j -= 1
	j while_loop
	
end_while:
	addi $t3, $t1, 1				# $t3 = j + 1
	sll $s2, $t3, 2				# $s2 = 4*(j+1)
	add $s2, $s2, $a0			# $s2 = address of A[j+1]
	sw $t2, 0($s2)				# A[j+1] = key
	addi $t0, $t0, 1				# i += 1
	j for_loop
	
done_for:
	j after_sort
	
# Code in C:
# void insertionSort(int arr[], int n)
# {
#    int i, key, j;
#    for (i = 1; i < n; i++)
#    {
#        key = arr[i];
#        j = i - 1;
#        while (j >= 0 && arr[j] > key)
#        {
#            arr[j + 1] = arr[j];
#            j = j - 1;
#        }
#        arr[j + 1] = key;
#    }
# }