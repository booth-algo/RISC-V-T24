# Reference: Peter Cheung, Lecture 9, 
# http://www.ee.ic.ac.uk/pcheung/teaching/EIE2-IAC/Lecture%209%20-%20Cache%20Memory%20(notes).pdf

main:
    addi s0, zero, 5
    addi s1, zero, 0

loop:
    beq s0, zero, done
    lw s2, 4(s1)
    lw s3, 12(s1)
    lw s4, 8(s1)
    addi s0, s0, -1
    j loop

done:
