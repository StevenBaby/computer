	.file	"hello.c"
# GNU C17 (GCC) version 11.1.0 (x86_64-pc-linux-gnu)
#	compiled by GNU C version 11.1.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -m32 -mpreferred-stack-boundary=2 -mtune=generic -march=x86-64 -O0 -fno-asynchronous-unwind-tables -fno-pic -fno-stack-protector -fno-builtin
	.text
	.section	.rodata
.LC0:
	.string	"hello world!!!\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
# hello.c:5:     printf("hello world!!!\n");
	pushl	$.LC0	#
	call	printf	#
	addl	$4, %esp	#,
	movl	$0, %eax	#, _3
# hello.c:6: }
	leave	
	ret	
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
