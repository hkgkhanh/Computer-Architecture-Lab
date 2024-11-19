.eqv KEY_CODE 0xFFFF0004			# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000			# =1 if has a new keycode ?
								# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C		# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008		# =1 if the display has already to do
								# Auto clear after sw
.text
	li $s3, 0x65786974 			# ASCII for "exit"
	li $k0, KEY_CODE
	li $k1, KEY_READY
 
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY
loop:
	nop
 
WaitForKey:
	lw $t1, 0($k1)				# $t1 = [$k1] = KEY_READY
	nop
	beq $t1, $zero, WaitForKey	# if $t1 == 0 then Polling
	nop
 #-----------------------------------------------------
ReadKey:
	lw $t0, 0($k0)				# $t0 = [$k0] = KEY_CODE
	nop
#------------------------------------------------------
Check_exit:
CheckE:
 	beq $t3, 1, CheckX
 	beq $t0, 101, next_phase
CheckX:
 	beq $t3, 2, CheckI
 	beq $t0, 120, next_phase
CheckI:
 	beq $t3, 3, CheckT
 	beq $t0, 105, next_phase
CheckT:
 	beq $t3, 4, Encrypt
 	beq $t0, 116, next_phase
 	
 addi $t3, $zero, 0
 #-----------------------------------------------------
WaitForDis:
	lw $t2, 0($s1)				# $t2 = [$s1] = DISPLAY_READY
	nop
	beq $t2, $zero, WaitForDis	# if $t2 == 0 then Polling 
	nop 
 #-----------------------------------------------------
Encrypt:
	addi $t0, $t0, 1				# change input key
 #-----------------------------------------------------
ShowKey:
	sw $t0, 0($s0)				# show key
	nop
	beq $t3, 4, end_main
 #----------------------------------------------------- 
	j loop
	nop

next_phase:
	addi $t3, $t3, 1
	j Encrypt
	
end_main:
	li $v0, 10					#exit
	syscall
#------------------------------------------------------
# Algorithm diagram:
#              == E         == X         == I            == T
#  ----->NULL ---------> E --------> EX ---------> EXI -------------> EXIT
#  |______|______________|____________|_____________|
#    != E        != X        != I          != T
#
# Y tuong thuat toan va so do dua vao hoc phan Dien tu cho CNTT
# Algorithm and diagram's idea is based on the subject Electronics for IT