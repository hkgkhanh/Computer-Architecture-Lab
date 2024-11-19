# Laboratory Exercise 2, Assignemt 4

.text
	# Assign X, Y
	addi $t1, $zero, 5	# X = $t1 = 5
	addi $t2, $zero, -1	# Y = $t2 = -1
	# Expression Z = 2X + Y
	add $s0, $t1, $t1
	add $s0, $s0, $t2
	
# Sụ thay đổi của các thanh ghi sau mỗi lệnh:

#	Sau lệnh 1:
#		$t1: 0x00000005
#		$pc: 0x00400004

#	Sau lệnh 2:
#		$t2: 0xffffffff
#		$pc: 0x00400008

#	Sau lệnh 3:
#		$s0: 0x0000000a
#		$pc: 0x0040000c

#	Sau lệnh 4:
#		$s0: 0x00000009
#		$pc: 0x00400010

# Khi kết thúc chương trình, kết quả là đúng: 2*5 + (-1) = 9

# Lệnh addi ở dòng 5:
#		opcode: 8     -> 001000
#		rs: $zero = 0 -> 00000
#		rt: $t1 = 9   -> 01001
#		imm: 5 = 0x5  -> 0000 0000 0000 0101
# Kết quả dịch: 0010 0000 0000 1001 0000 0000 0000 0101
# Mã Hexa: 0x20090005

# Lệnh addi ở dòng 6:
#		opcode: 8               -> 001000
#		rs:     $zero = 0       -> 00000
#		rt:     $t2 = 10        -> 01010
#		imm:    -1 = 0xffffffff -> 1111 1111 1111 1111
# Kết quả dịch: 0010 0000 0000 1010 1111 1111 1111 1111
# Mã Hexa: 0x200affff

# Lệnh add ở dòng 8
#		opcode: 0        -> 000000
#		rs:     $t1 = 9  -> 01001
#		rt:     $t1 = 9  -> 01001
#		rd:     $s0 = 16 -> 10000
#		sh:     0        -> 00000
#		fn:     32       -> 100000
# Kết quả dịch: 0000 0001 0010 1001 1000 0000 0010 0000
# Mã Hexa: 0x01298020

# Lệnh add ở dòng 9
#		opcode: 0        -> 000000
#		rs:     $s0 = 16 -> 10000
#		rt:     $t2 = 10 -> 01010
#		rd:     $s0 = 16 -> 10000
#		sh:     0        -> 00000
#		fn:     32       -> 100000
# Kết quả dịch: 0000 0010 0000 1010 1000 0000 0010 0000
# Mã Hexa: 0x020a8020