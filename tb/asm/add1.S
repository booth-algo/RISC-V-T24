main:
    addi    a0, zero, 0xff          # a0 = 0xff
    addi    a1, zero, 0xff          # a1 = 0xff
    add     t1, a0, t1              # t1 = a0 + a1
    
    # EXPECTED OUTPUT: t1 = 510
