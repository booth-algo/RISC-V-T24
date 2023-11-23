main:
    li      s4, 0x0

loop:
    lw      

    JAL     ra, SUBROUTINE
    ret     

SUBROUTINE:
    addi    a0, zero, 0x1
    addi    a0, zero, 0x3
    addi    a0, zero, 0x7
    addi    a0, zero, 0xF
    addi    a0, zero, 0x1F
    addi    a0, zero, 0x3F
    addi    a0, zero, 0x7F
    addi    a0, zero, 0xFF
    ret