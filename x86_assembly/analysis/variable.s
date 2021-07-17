	.file	"variable.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp

	subl	$8, %esp

	leal	-5(%ebp), %eax

	movl	$1819043176, (%eax)
	movl	$1870078063, 4(%eax)
	movl	$174353522, 8(%eax)
	movb	$0, 12(%eax)

	movl	$0, %eax

	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
