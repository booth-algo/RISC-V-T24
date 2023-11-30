.text
.globl main
main:
    addi    t1, zero, 0xff      # load t1 with 255
    addi    a0, zero, 0x0       # a0 is used for output
mloop:     
    addi    a1, zero, 0x0       # a1 is the counter, init to 0
iloop:
    addi    a0, a1, 0           # load a0 with a1
    addi    a1, a1, 1           # increment a1
    bne     a1, t1, iloop       # if a1 = 255, branch to iploop
    bne     t1, zero, mloop     #  ... else always brand to mloop
