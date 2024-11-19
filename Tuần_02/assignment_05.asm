# Laboratory Exercise 2, Assignment 5

.text
	# Assign X, Y
	addi $t1, $zero, 4	# X = $t1 = 4
	addi $t2, $zero, 5	# Y = $t2 = 5
	# Expression Z = 3 * X * Y
	mul $s0, $t1, $t2	# HI-LO = $t1 * $t2 = X * Y; $s0 = LO
	mul $s0, $s0, 3		# $s0 = $s0 * 3
	# Z' = Z
	mflo $s1
	
# Điều bất thường: lệnh mul ở dòng 9 được dịch thành 2 câu lệnh addi và mul (trong cửa sổ Text Segment).
# Giải thích: Lệnh mul chỉ nhận tham số là các thanh ghi, vì vậy trước hết thực hiện lệnh addi
#             để truyền giá trị 3 vào thanh ghi $1 sau đó thực hiện phép nhân $s0 = $s0 * $1.

# Sụ thay đổi của các thanh ghi sau mỗi lệnh:

#	Sau lệnh 1:
#		$t1: 0x00000004
#		$pc: 0x00400004

#	Sau lệnh 2:
#		$t2: 0x00000005
#		$pc: 0x00400008

#	Sau lệnh 3:
#		$s0: 0x00000014
#		$pc: 0x0040000c
#		$lo: 0x00000014

#	Sau lệnh 4:
#		$at: 0x00000003
#		$pc: 0x00400010

#	Sau lệnh 5:
#		$s0: 0x0000003c
#		$pc: 0x00400014
#		$pc: 0x0000003c

# Sau khi kết thúc chương trình, kết quả của phép nhân nằm ở thanh ghi $s1 là chính xác.