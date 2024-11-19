# Laboratory Exercise 2, Assignment 2

.text
	lui $s0, 0x2110			# put upper half of pattern in $s0
	ori $s0, $s0, 0x003d		# put lower half of pattern in $s0

# Sụ thay đổi của các thanh ghi sau mỗi lệnh:

#	Sau lệnh 1:
#		$s0: 0x21100000
#		$pc: 0x00400004

#	Sau lệnh 2:
#		$s0: 0x2110003d
#		$pc: 0x00400008

# Các byte đầu tiên trong vùng lệnh .text trùng với cột code trong cửa sổ Text Segment