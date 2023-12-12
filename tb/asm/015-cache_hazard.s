main:
    li x10, 0x01
    sw x10, 0(x11)          # Write to address 0
    nop                     # Optional: Insert NOPs to separate instructions
    li x10, 0x02
    sw x10, 4(x11)          # Write to address 4
    nop
    li x10, 0x03
    sw x10, 8(x11)          # Write to address 8
    nop
    lw x12, 0(x11)          # Read from address 0
    lw x13, 4(x11)          # Read from address 4
    lw x14, 8(x11)          # Read from address 8
