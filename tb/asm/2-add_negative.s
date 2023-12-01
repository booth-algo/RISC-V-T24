# Same as 1-add_positive.s BUT negative

main:
	addi a0, zero, -32
    addi a0, a0, -101
    addi a1, zero, -52
    addi a1, a1, -61
    
    add a0, a0, a1
    
	# EXPECTED OUTPUT = -246
