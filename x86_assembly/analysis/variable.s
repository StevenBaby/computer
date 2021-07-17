	.file	"variable.c"
	.text

	.globl	a
	.bss
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.zero	4

	.globl	b
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.zero	4

	.globl	c
	.data
	.align 4
	.type	c, @object
	.size	c, 4
c:
	.long	5

	.align 4
	.type	d, @object
	.size	d, 4
d:
	.long	8

	.section	.rodata
	.align 4
	.type	e, @object
	.size	e, 4
e:
	.long	10

	.globl	array
	.bss
	.align 4
	.type	array, @object
	.size	array, 20
array:
	.zero	20

	.globl	iarray
	.data
	.align 4
	.type	iarray, @object
	.size	iarray, 20
iarray:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5

	.globl	message
	.align 4
	.type	message, @object
	.size	message, 13
message:
	.string	"hello world\n"
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
