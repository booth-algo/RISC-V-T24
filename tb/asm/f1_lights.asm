// for vbuddy testing, an extra mux can be added to implement a test although not necesarry
main: 
li 		t2, 0x2000
iloop:
lw 		s0, 0(t2)
JAL 	ra, subroutine
j		iloop
ret

subroutine:
addi 	a0, zero, 0x1
addi 	a0, zero, 0x3
addi 	a0, zero, 0x7
addi 	a0, zero, 0xf
addi 	a0, zero, 0x1f
addi 	a0, zero, 0x3f
addi 	a0, zero, 0x7f
addi 	a0, zero, 0xff
ret
