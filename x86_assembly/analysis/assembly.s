	.file	"assembly.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d + %d = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$12, %esp
	movl	$10, -4(%ebp)
	movl	$20, -8(%ebp)
	movl	$30, -12(%ebp)
	movl	-8(%ebp), %edx
#APP
# 10 "assembly.c" 1
	movl $10, %eax
movl $20, %edx

# 0 "" 2
#NO_APP
	movl	%eax, -4(%ebp)
	pushl	-12(%ebp)
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
