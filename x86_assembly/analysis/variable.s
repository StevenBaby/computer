	.file	"variable.c"
	.text
	.globl	fun1
	.type	fun1, @function
fun1:
	pushl	%ebp
	movl	%esp, %ebp
	nop
	popl	%ebp
	ret
	.size	fun1, .-fun1
	.globl	fun2
	.type	fun2, @function
fun2:
	pushl	%ebp
	movl	%esp, %ebp
	nop
	popl	%ebp
	ret
	.size	fun2, .-fun2
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$5, -4(%ebp)
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.data
	.align 4
	.type	a.2, @object
	.size	a.2, 4
a.2:
	.long	3
	.align 4
	.type	a.1, @object
	.size	a.1, 4
a.1:
	.long	5

	.local	a.0
	.comm	a.0,4,4
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
