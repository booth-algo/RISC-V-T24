main:
    addi x13, x13, 0x1
    sw x13, 0(x10)

    addi x13, x13, 0x1
    sw x13, 4(x10)

    addi x13, x13, 0x1
    sw x13, 8(x10)

    addi x13, x13, 0x1
    sw x13, 12(x10)

    # Read Test
    lb x11, 0(x10)   # Read first word, expect cache miss
    lb x11, 1(x10)   # Read second word, expect cache miss
    lb x11, 0(x10)   # Read first word again, expect cache hit

    # The expected behaviour cannot be emulated properly due to the need of reading address while storing word