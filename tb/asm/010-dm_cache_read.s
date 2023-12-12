.section .text
.global main

main:
    la x10, array   # Load the address of the array into x10

    # Read Test
    lw x11, 0(x10)   # Read first word, expect cache miss
    lw x12, 4(x10)   # Read second word, expect cache miss
    lw x11, 0(x10)   # Read first word again, expect cache hit

.section .data
array: .word 0x11111111, 0x22222222, 0x33333333, 0x44444444