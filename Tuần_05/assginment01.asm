# Laboratory Exercise 5, Home Assignment 1, Assignment 1

.data
	test: .asciiz "Hello World"
	
.text
	li $v0, 4		# service is print string
	la $a0, test		# the string to be printed is test
	syscall			# excute

# Em trinh bay bang tieng Anh vi tieng Viet bi loi font a, mong thay va anh tro giang thong cam.

# The pointer to Test string is stored in address 0x10010000 for the whole program.
# Each character takes up 1 byte (8 bits), stored sequencially in order according to the string.
# After the last character 'd', there is a NULL character '\0', indicate the end of the string.