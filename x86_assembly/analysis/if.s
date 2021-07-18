	.file	"if.c"
	.text
	.globl	compare
	.type	compare, @function

compare:
	pushl	%ebp
	movl	%esp, %ebp

	# ebp ebp
	# eip
	# condition ebp + 8
	# a ebp + 12
	# b ebp + 16

	cmpl	$0, 8(%ebp) # condition
	je	.L2
	movl	12(%ebp), %eax # eax = a
	jmp	.L3
.L2:
	movl	16(%ebp), %eax # eax = b
.L3:
	popl	%ebp
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
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
