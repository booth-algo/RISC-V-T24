# for vbuddy testing, an extra mux can be added to implement a test although not necesarry
main: 
    li 		t2, 0x2000
loop:
    lw 		s0, 0(t2)
    jal 	ra, subroutine
    j		loop
    ret

subroutine:
    addi 	a0, zero, 0x1
    addi 	a0, zero, 0x3
    addi 	a0, zero, 0x7
    addi 	a0, zero, 0xf
    addi 	a0, zero, 0x1f
    addi 	a0, zero, 0x3f
    addi 	a0, zero, 0x7f
    ret
