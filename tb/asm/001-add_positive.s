# Same as 1-add_positive.c BUT without lw and sw

main:
	addi a0, zero, 32
    nop
    nop
    nop
    addi a0, a0, 101
    nop
    nop
    nop
    addi a1, zero, 52
    nop
    nop
    nop
    addi a1, a1, 61
    nop
    nop
    nop
    add a0, a0, a1
    
	# EXPECTED OUTPUT = 246
