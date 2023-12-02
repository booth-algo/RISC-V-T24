# Test lw and sw instructions

main:
	addi t1, zero, -61          # t1 = -61
    addi a1, zero, 32           # a1 = 32
    sw t1, 1(a1)                # Reg[32 + 1] = -61
    addi t1, zero, 0            # Clear t1
    lw a0, 1(a1)                # a0 = Reg[32 + 1] = -61
    addi a0, a0, -61
    
	# EXPECTED OUTPUT = -122
