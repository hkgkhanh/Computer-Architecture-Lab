# Laboratory Exercise 2, Assignment 6

.data
	X: .word 5	# variable X, word type, init value = 5
	Y: .word -1	# variable Y, word type, init value = -1
	Z: .word		# variable Z, word type, no init value
	
.text
	# Load X, Y to registers
	la $t8, X			# Get the address of X in Data Segment
	la $t9, Y			# Get the address of Y in Data Segment
	lw $t1, 0($t8)		# $t1 = X
	lw $t2, 0($t9)		# $t2 = Y
	
	# Calculate the expression Z = 2X + Y with registers only
	add $s0, $t1, $t1	# $s0 = $t1 + $t1 = X + X
	add $s0, $s0, $t2	# $s0 = $s0 + $t2 = 2X + Y
	
	# Store result from register to variable Z
	la $t7, Z			# Get the address of Z in Data Segment
	sw $s0, 0($t7)		# Z = $s0 = 2X + Y
	
# Lệnh la được dịch thành lệnh lui và lệnh ori, có tác dụng gán 1 số 32 bit vào thanh ghi.
# Khi biên dịch thành mã máy, địa chỉ của các biến X, Y, Z là liên tiếp nhau, lần lượt là 0x10010000, 0x10010004 và 0x10010008.
# Giá trị của các biến X, Y, Z là chính xác so với các giá trị khởi tạo.

# Sụ thay đổi của các thanh ghi sau mỗi lệnh:

#	Sau lệnh 1:
#		$1: 0x10010000
#		$pc: 0x00400004

#	Sau lệnh 2:
#		$t8: 0x10010000
#		$pc: 0x00400008

#	Sau lệnh 3:
#		$1: 0x10010000
#		$pc: 0x0040000c

#	Sau lệnh 4:
#		$t9: 0x10010004
#		$pc: 0x00400010

#	Sau lệnh 5:
#		$t1: 0x00000005
#		$pc: 0x00400014

#	Sau lệnh 6:
#		$t2: 0xffffffff
#		$pc: 0x00400018

#	Sau lệnh 7:
#		$s0: 0x0000000a
#		$pc: 0x0040001c

#	Sau lệnh 8:
#		$s0: 0x00000009
#		$pc: 0x00400020

#	Sau lệnh 9:
#		$1: 0x10010000
#		$pc: 0x00400024

#	Sau lệnh 10:
#		$t7: 0x10010008
#		$pc: 0x00400028

# Vai trò của lệnh lw: Cú pháp: lw $d_reg, offset($b_reg)
# Giải thích: offset là khoảng cách từ $b_reg đến vị trí trong bộ nhớ mà người lập trình muốn nạp giá trị từ.
#             Lệnh lw nạp giá trị từ thanh ghi offset($b_reg) vào thanh ghi $d_reg.
#             Trong đoạn code trên, lệnh lw nạp giá trị của thanh ghi $t8 (biến X) vào $t1.

# Vai trò của lệnh sw: Cú pháp: sw $s_reg, offset($b_reg)
# Giải thích: offset là khoảng cách từ $b_reg đến vị trí trong bộ nhớ mà người lập trình muốn lưu giá trị vào.
#             Lệnh sw lưu giá trị từ thanh ghi $s_reg vào thanh ghi offset($b_reg), thường là địa chỉ của 1 biến hoặc 1 phần của bộ nhớ (memory).
#             Trong đoạn code trên, lệnh sw lưu giá trị của thanh ghi $s0 vào $t7 (biến Z).