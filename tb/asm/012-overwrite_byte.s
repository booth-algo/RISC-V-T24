main:
    li x13, 0x01
    sb x13, 0(x11)
    
    li x13, 0x02
    sb x13, 1(x11)

    li x13, 0x03
    sb x13, 2(x11)
    
    li x13, 0x04
    sb x13, 3(x11)

    lw x12, 0(x11)

    li x10, 0xFF                     
    sb x10, 0(x11)
    sb x10, 1(x11)

    lw x10, 0(x11)                    
