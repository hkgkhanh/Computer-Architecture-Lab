.eqv SEVENSEG_LEFT 0xFFFF0011		# Dia chi cua den led 7 doan trai.
								# Bit 0 = doan a; 
								# Bit 1 = doan b; ... 
								# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010	# Dia chi cua den led 7 doan phai
.data
	Map: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text
main:
	addi $t9, $zero, 9			# constant 9 for comparison below
	la $s0, Map					# $s0 points to the array Map
	addi $s1, $zero, 0			# initialize left_counter for 7SEG_LEFT
	addi $s2, $zero, 0			# initialize right_counter for 7SEG_RIGHT

loop:
	addi $v0,$zero,32			# freeze for 1000ms
	li $a0,1000 
	syscall
	
	addi $s2, $s2, 1				# right_counter += 1
	slt $t0, $t9, $s2			# $t0 = 9 < right_counter ? 1 : 0
	beq $t0, $zero, skip1		# if 9 >= right_counter then skip the next line
	
	addi $s2, $zero, 0			# re-assign right_counter = 0
	addi $s1, $s1, 1				# left_counter += 1
	slt $t1, $t9, $s1			# $t1 = 9 < left_counter ? 1 : 0
	beq $t1, $zero, skip1		# if 9 >= left_counter then skip the next line
	addi $s1, $zero, 0			# re-assign left_counter = 0
	
skip1:
	
	sll $t1, $s1, 2
	add $t1, $t1, $s0			# $t1 points to Map[left_counter]
	
	lw $a0, 0($t1)				# set value for 7SEG_LEFT
	jal SHOW_7SEG_LEFT			# show
	nop
	
	sll $t0, $s2, 2
	add $t0, $t0, $s0			# $t0 points to Map[right_counter]
	
	lw $a0, 0($t0)				# set value for 7SEG_RIGHT
	jal SHOW_7SEG_RIGHT			# show
	nop
	j loop						# jump back to update counters
exit:
	li $v0, 10
	syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown 
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
	li $t0, SEVENSEG_LEFT		# assign port's address
	sb $a0, 0($t0)				# assign new value 
	nop
	jr $ra
	nop
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown 
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:
	li $t0, SEVENSEG_RIGHT		# assign port's address
	sb $a0, 0($t0)				# assign new value
	nop
	jr $ra 
	nop