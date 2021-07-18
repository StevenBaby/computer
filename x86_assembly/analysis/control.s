	.file	"control.c"
	.text
	.globl	compare
	.type	compare, @function
compare:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$0, -4(%ebp)
	jmp	.L2
.L6:
	cmpl	$0, 8(%ebp)
	je	.L7
	nop
	addl	$1, -4(%ebp)
.L2:
	cmpl	$9, -4(%ebp)
	jle	.L6
	jmp	.L5
.L7:
	nop
.L5:
	nop
	leave
	ret
	.size	compare, .-compare
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	$3
	pushl	$2
	pushl	$1
	call	compare
	addl	$12, %esp
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.globl	test
	.type	test, @function
test:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$12, %esp
	movl	$1, -4(%ebp)
	movl	$2, -8(%ebp)
	movl	$3, -12(%ebp)
	cmpl	$3, -4(%ebp)
	jne	.L11
	addl	$1, -8(%ebp)
	cmpl	$5, -8(%ebp)
	jne	.L12
	addl	$1, -4(%ebp)
	cmpl	$6, -12(%ebp)
	jne	.L15
	addl	$1, -12(%ebp)
	jmp	.L15
.L12:
	cmpl	$6, -8(%ebp)
	jne	.L14
	addl	$1, -4(%ebp)
	jmp	.L14
.L11:
	addl	$1, -4(%ebp)
	jmp	.L14
.L15:
	nop
.L14:
	addl	$1, -4(%ebp)
	nop
	leave
	ret
	.size	test, .-test
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
