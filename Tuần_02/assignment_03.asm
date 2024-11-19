# Laboratory Exercise 2, Assignment 3

.text
	li $s0, 0x2110003d	# pseudo instruction = 2 basic instructions
	li $s1, 0x2			# but if the immediate value is small, 1 instruction
	
# Điều bất thường: Lệnh li thứ nhất được biên dịch thành lệnh lui và ori (giống ở assignment 2);
#                  Lệnh li thứ hai được biên dịch thành lệnh addiu.
# Giải thích:
# Lệnh li chỉ nhận giá trị là số 16 bit nên ở lệnh li đầu tiên, số 0x2110003d là số 32 bit nên cần
# tách ra thành 2 lệnh lui và ori để xử lí từng 16 bit một. Ở lệnh li thứ hai, số 0x2 là số 16 bit
# nên được dịch thành lệnh addiu.