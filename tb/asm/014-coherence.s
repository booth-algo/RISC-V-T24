    # Assuming x11 holds the base address of your data
    li x10, 0x01
    sw x10, 0(x11)          # Write 0x01 to address pointed by x11 (cache is updated)

    # ... other instructions might be here ...

    lw x12, 0(x11)          # Read back the value into x12 (should get 0x01 if cache is correct)

    # Now, modify the cache by writing a new value to the same address
    li x10, 0x02
    sw x10, 0(x11)          # Write 0x02 to the same address (cache content at this address is modified)

    # Optionally, introduce a delay to allow for cache write-back if it's write-back cache
    # For example, a simple delay loop or a number of nop instructions

    lw x13, 0(x11)          # Read again into x13 (should get 0x02 if cache was correctly modified)
