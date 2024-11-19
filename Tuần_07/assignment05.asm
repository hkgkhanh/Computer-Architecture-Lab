#Laboratory Exercise 7, Assignmen 5
.data
	Message1: .asciiz "Largest: "
	Message2: .asciiz "\nSmallest: "
	comma: .asciiz ", at $s"
.text
main:
	li $s0, 12				# initialize $s0 -> $s7
	li $s1, 10
	li $s2, 20
	li $s3, 4
	li $s4, 1
	li $s5, 4
	li $s6, 20
	li $s7, 5
	
	addi $sp,$sp,-32			# adjust the stack pointer
	sw $s7,28($sp)			# push $s7 to stack
	sw $s6,24($sp)			# push $s6 to stack
	sw $s5,20($sp)			# push $s5 to stack
	sw $s4,16($sp)			# push $s4 to stack
	sw $s3,12($sp)			# push $s3 to stack
	sw $s2,8($sp)			# push $s2 to stack
	sw $s1,4($sp)			# push $s1 to stack
	sw $s0,0($sp)			# push $s0 to stack
	
	jal MIN_MAX_POS
 
print:
	li $v0, 4
	la $a0, Message1
	syscall

 	li $v0, 1
	lw $a0, 0($sp)
	addi $sp, $sp, 4			# update stack pointer
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall

 	li $v0, 1
	lw $a0, 0($sp)
	addi $sp, $sp, 4			# update stack pointer
	syscall
	
	
	li $v0, 4
	la $a0, Message2
	syscall

 	li $v0, 1
	lw $a0, 0($sp)
	addi $sp, $sp, 4			# update stack pointer
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall

 	li $v0, 1
	lw $a0, 0($sp)
	addi $sp, $sp, 4			# update stack pointer
	syscall
quit:
	li $v0, 10				# terminate
	syscall 
endmain:
#---------------------------------------------------------------------
#Procedure MIN_MAX_POS
#$t0: min value; $t1: max value
#$t2: min value index; $t3: max value index
#---------------------------------------------------------------------
MIN_MAX_POS:
	lw $t0, 0($sp)			# max := ($s0)
	lw $t1, 0($sp)			# min := ($t0)
	addi $t2, $zero, 0		# max_i := 0
	addi $t3, $zero, 0		# min_i := 0
	addi $sp, $sp, 4			# adjust the stack pointer
	addi $t4, $zero, 1		# $t4 is the index of the loop (i)
	addi $t8, $zero, 8		# first value after the last index of loop (for jumping out of loop)
loop:
	beq $t4, $t8, done_loop	# if i >= 8 then done loop
	lw $t5, 0($sp)			# load the next value from stack
	addi $sp, $sp, 4			# adjust the stack pointer
	
	slt $t6, $t5, $t1		# check if current < min
	beq $t6, $zero, skip_min	# if false then skip
	add $t1, $zero, $t5		# set min := current
	add $t3, $zero, $t4		# set min_i := i
	
skip_min:
	slt $t6, $t0, $t5		# check if current > max
	beq $t6, $zero, skip_max	# if false then skip
	add $t0, $zero, $t5		# set max := current
	add $t2, $zero, $t4		# set max_i := i
	
skip_max:
	addi $t4, $t4, 1			# i += 1
	j loop
done_loop:
	addi $sp,$sp,-16			#adjust the stack pointer
	sw $t3,12($sp)			#push $t0 to stack
	sw $t1,8($sp)			#push $t2 to stack
	sw $t2,4($sp)			#push $t1 to stack
	sw $t0,0($sp)			#push $t3 to stack
	jr $ra
MIN_MAX_POS_end:
