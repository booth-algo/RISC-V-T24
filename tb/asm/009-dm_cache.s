.section .text
.global main   # Mark 'main' as the entry point

main:
    la t0, array   # Load the address of the array into t0

    # Read Test
    lw t1, 0(t0)   # Read first word, expect cache miss
    lw t2, 4(t0)   # Read second word, expect cache miss
    lw t1, 0(t0)   # Read first word again, expect cache hit

    # Write Test
    li t3, 0x55555555
    sw t3, 0(t0)   # Write to first word, expect hit (write-through)
    li t3, 0x66666666
    sw t3, 12(t0)  # Write to a new address, expect miss and replacement

    # Validation Read
    lw t4, 0(t0)   # Read first word, expect hit
    lw t4, 12(t0)  # Read new address, expect hit

    # End of test - replace with a proper exit if needed
hang:   j hang

.section .data
array:  .word 0x11111111, 0x22222222, 0x33333333, 0x44444444
