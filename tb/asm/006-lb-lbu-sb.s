# Test lb, lbu and sb instructions

main:
	addi t1, zero, -61          # t1 = -61 = 0xFFC3
    addi a1, zero, 32           # a1 = 32 = 0x0020
    sb t1, 1(a1)                # Reg[32 + 1] = 0x0003
    addi t1, zero, 0            # Clear t1: t1 = 0
    lb a0, 1(a1)                # a0 = Reg[32 + 1] = 0x0003
    addi a0, a0, -61            # a0 = a0  - 61 = -58
    
	# EXPECTED OUTPUT = -58
