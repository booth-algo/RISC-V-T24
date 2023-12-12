main:
    li x10, 0x12345678
    sw x10, 0(x11)          # Store the word
    lb x12, 0(x11)          # Load first byte
    lb x13, 1(x11)          # Load second byte
    lb x14, 2(x11)          # Load third byte
    lb x10, 3(x11)          # Load fourth byte
