	.file	"hello.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"hello world!!!"
	.text
	.globl	main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	push	OFFSET FLAT:.LC0
	call	puts
	add	esp, 4
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
