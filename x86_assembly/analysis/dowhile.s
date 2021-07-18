	.file	"dowhile.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$0, -4(%ebp)
	movl	$10, -8(%ebp)
.L2:
	movl	-8(%ebp), %eax
	addl	%eax, -4(%ebp)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, -8(%ebp)
	testl	%eax, %eax
	jne	.L2
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
