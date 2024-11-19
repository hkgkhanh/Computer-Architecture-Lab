# Mini project (mid-term), group 2, exercise 2
# Find all prime numbers in a range from the integer N to integer M

.data
	message1: .asciiz "Input N >= 1:"
	message2: .asciiz "Input M (must be >= N and >= 1, else re-input M):"
	message3: .asciiz "All prime numbers from N to M:\n"
	space: .asciiz ", "
	none: .asciiz "No prime number between N and M"
	
.text
main:
input_N:
	li $v0, 51							# code 51 for input integer
	la $a0, message1
	syscall
	add $s0, $zero, $a0					# store N to $s0
	
input_M:
	li $v0, 51							# code 51 for input integer
	la $a0, message2
	syscall
	add $s1, $zero, $a0					# store M to $s1
	
	addi $t0, $zero, 1					# temp variable for compare below
	slt $t0, $s0, $t0
	beq $t0, $zero, skip_constrain_N		# if N < 1 then N = 1
	addi $s0, $zero, 1					# N := 1
	
skip_constrain_N:
	slt $t0, $s1, $s0
	bne $t0, $zero, input_M				# if M < N then input M again

	li $v0, 4							# code 4 for print string
	la $a0, message3
	syscall

	add $s3, $zero, $zero				# prime number count
	add $t0, $zero, $s0					# i = $t0 starts at N
	
for_loop_N_to_M:
	slt $t1, $s1, $t0					# check i > M
	bne $t1, $zero, end_for_loop			# if i > M then jump out of loop
	add $a0, $t0, $zero					# parameter for is_prime procedure
	jal is_prime							# start procedure
	add $t7, $zero, $v0					# ($t7) := returned value
	beq $t7, $zero, skip_print			# if i is not prime then don't print it
	
	beq $s3, $zero, skip_print_comma		# for display purpose
	li $v0, 4							# code 4 for print string
	la $a0, space
	syscall

skip_print_comma:
	li $v0, 1							# code 4 for print integer
	la $a0, ($t0)						# print i
	syscall
	
	addi $s3, $s3, 1						# increase the count of prime numbers found
	
skip_print:
	addi $t0, $t0, 1						# i++
	j for_loop_N_to_M					# jump back to loop
	
end_for_loop:
	bne $s3, $zero, end_main				# if there is no prime number then display a message
	li $v0, 4							# code 4 for print string
	la $a0, none
	syscall

end_main:
	li $v0, 10							# terminate
	syscall

#---------------------------------------------------------------------
#Procedure is_prime
# @brief Check if the input parameter is prime, if the input number is
# prime then return 1, else return 0
# @param[in] $a0 The number to check
# @return $v0 Register that contains the returned value
#---------------------------------------------------------------------
is_prime:
	addi $t3, $zero, 2					# temp variable for comparison below
	slt $t2, $a0, $t3					# check ($a0) < 2
	bne $t2, $zero, is_false				# if ($a0) < 2 then is not prime
	addi $t4, $zero, 2					# index i of for loop starts at 2
	
is_prime_for_loop:
	mul $t5, $t4, $t4					# ($t5) = i * i
	slt $at, $a0, $t5					# check i * i > ($a0)
	bne $at, $zero, is_true				# if i * i > ($a0) then is prime
	div $a0, $t4							# divide ($a0) by i
	mfhi $t6								# ($t6) := remainder of the division
	beq $t6, $zero, is_false				# if $a0 % i == 0 then is not prime
	addi $t4, $t4, 1						# i++
	j is_prime_for_loop					# jump back to loop
	
is_false:
	addi $v0, $zero, 0					# return 0 if is not prime
	jr $ra								# return to main
	
is_true:
	addi $v0, $zero, 1					# return 1 if is prime
	jr $ra								# return to main