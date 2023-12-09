# Test lb, lbu and sb instructions

main:
	addi t1, zero, -61
    addi a1, zero, 32
    sb t1, 1(a1)
    addi t1, zero, 0
    lbu a0, 1(a1)
    addi a0, a0, -61
    
	# EXPECTED OUTPUT = 134
