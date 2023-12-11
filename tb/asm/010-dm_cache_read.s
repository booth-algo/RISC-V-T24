.section .text
.global main

main:
    la t0, array
    lw t1, 0(t0)
    lw t2, 4(t0)
    lw t1, 0(t0)
    # Need some signal that tests cache miss and hit

.section .data
array: .word 0x11111111, 0x22222222, 0x33333333, 0x44444444