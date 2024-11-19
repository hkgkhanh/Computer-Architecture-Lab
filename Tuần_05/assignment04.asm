# Laboratory Exercise 5, Home Assignment 3, Assignment 4

.data
	string: .space 50
	Message1: .asciiz "Nhap xau: "
	Message2: .asciiz "Do dai xau la: "
	
.text
main:
get_string: # TODO
	li $v0, 54					# service is input dialog string
	la $a0, Message1				# prompt "Nhap xau: "
	la $a1, string				# read input to variable string
	la $a2, 50					# maximum string length is 50
	syscall
 
get_length:
	la $a0,string 				# $a0 = address(string[0])
	add $t0,$zero,$zero 			# $t0 = i = 0
	
check_char:
	add $t1,$a0,$t0				# $t1 = $a0 + $t0 = address(string[i])
	lb $t2, 0($t1) 				# $t2 = string[i]
 	beq $t2, $zero, end_of_str 	# is null char?
	addi $t0, $t0, 1	 			# i += 1
	j check_char
	
end_of_str: 
end_of_get_length:
print_length: # TODO
	#bne $t2, '\n', skip
	addi $t0, $t0, -1			# uncount the \n at the end
#skip:
	li $v0, 56					# service is message dialog integer
	la $a0, Message2				# prompt "Do dai xau la: "
	la $a1, ($t0)				# ouput is length of string
	syscall
