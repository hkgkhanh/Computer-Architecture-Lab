# Laboratory Exercise 4, Assignment 2

.text
	addi $s0, $zero, 0x12345678	# Initialize $s0
	andi $t0, $s0, 0xff000000	# Extract MSB of $s0, save to $t0
	srl $t1, $t0, 24				# Shift the MSB value to LSB, save to $t1
	
	andi $s0, $s0, 0xffffff00	# Clear LSB of $s0
	ori $s0, $s0, 0x000000ff		# Set LSB of $s0 to 1
	and $s0, $s0, $zero			# Clear $s0