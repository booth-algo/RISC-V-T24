	.file	"1-add_positive.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	li	a5,32
	sw	a5,-20(s0)
	li	a5,52
	sw	a5,-24(s0)
	li	a5,101
	sw	a5,-28(s0)
	li	a5,61
	sw	a5,-32(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	add	a4,a4,a5
	lw	a5,-28(s0)
	add	a5,a4,a5
	lw	a4,-32(s0)
	add	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
