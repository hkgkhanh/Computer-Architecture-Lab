# Laboratory Exercise 2, Assignment 1

# PHẦN ĐẦU CỦA ASSIGNMENT
#.text
#	addi $s0, $zero, 0x3007	# $s0 = 0 + 0x3007 = 0x3007; I-type
#	add $s0, $zero, $0		# $s0 = 0 + 0 = 0; R-type
	
# Sụ thay đổi của các thanh ghi sau mỗi lệnh:

#	Sau lệnh 1:
#		$s0: 0x00003007
#		$pc: 0x00400004

#	Sau lệnh 2:
#		$s0: 0x00000000
#		$pc: 0x00400008

# Dịch lệnh ở dòng 4:
# 		addi   -> 001000 (op)
#		$s0    -> 10000 (rt)
#		$zero  -> 00000 (rs)
#		0x3007 -> 0011 0000 0000 0111 (operand)
# Kết quả dịch: 0010 0000 0001 0000 0011 0000 0000 0111
# Ở mã Hexa: 0x20103007; đúng với kiến trúc tập lệnh

# Dịch lệnh ở dòng 5:
#		add   -> 000000 (op)
#		$s0   -> 10000 (rd)
#		$zero -> 00000 (rs)
#		$0    -> 00000 (rt)
#		shift amount = 0 -> 00000 (sh)
#		opcode extension -> 100000 (fn)
# Kết quả dịch: 0000 0000 0000 0000 1000 0000 0010 0000
# Ở mã Hexa: 0x00008020; đúng với kiến trúc tập lệnh

# PHẦN SAU CỦA ASSIGNMENT (SỬA LẠI LỆNH)
.text
	addi $s0, $zero, 0x3007	# $s0 = 0 + 0x3007 = 0x3007; I-type
	addi $s0, $zero, 0x2110003d
	
# Khi viết lệnh như trên, chương trình thực hiện các lệnh sau:
#		addi $s0, $zero, 0x3007
#		lui $1, 0x00002110
#		ori $1, $1, 0x0000003d
#		add $16, $0, $1

# Giải thích:
# lệnh lui nạp giá trị không dấu 16 bit (nhóm 4 bit đầu tiên) vào thanh ghi để tạo ra 1 giá trị 32 bit.
# ở đây lệnh lui nạp giá trị 0x2110 và dịch lên 16 bit thành 0x21100000 sau đó lưu ở thanh ghi $1.
# lệnh ori thực hiện phép toán OR giữa giá trị ở thanh ghi $1 và giá trị immediate là 0x3d, kết quả được lưu vào thanh ghi $1.
# cuối cùng, lệnh add cộng giá trị ở thanh ghi $0 và giá trị ở thanh ghi $1, sau đó lưu kết quả ở thanh ghi $16 (là thanh ghi $s0).
