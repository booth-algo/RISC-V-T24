#   Same as Lab1 - counts from 0 to 255

main:
    addi    t1, zero, 0xff          # t1 = 255
    addi    a0, zero, 0x0           # a0 is used for output
mloop:
    addi    a1, zero, 0x0           # a1 is the counter, init to 0
iloop:
    addi    a0, a1, 0               # a0 = a1
    addi    a1, a1, 1               # a1++
    bne     a1, t1, iloop           # if a1 != 255, branch to iloop
    bne     t1, zero, mloop         # else branch to mloop (t1 != zero -> False)
