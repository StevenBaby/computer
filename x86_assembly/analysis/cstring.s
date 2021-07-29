	.file	"cstring.c"
	.text
	.globl	memcpy
	.type	memcpy, @function
memcpy:
	subl	$12, %esp
	movl	16(%esp), %eax
	movl	%eax, 4(%esp)
	movl	20(%esp), %eax
	movl	%eax, (%esp)
	movl	$0, 8(%esp)
	jmp	.L2
.L3:
	movl	(%esp), %edx
	movl	8(%esp), %eax
	addl	%edx, %eax
	movl	4(%esp), %ecx
	movl	8(%esp), %edx
	addl	%ecx, %edx
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	addl	$1, 8(%esp)
.L2:
	movl	8(%esp), %eax
	cmpl	24(%esp), %eax
	jb	.L3
	movl	16(%esp), %eax
	addl	$12, %esp
	ret

	.size	memcpy, .-memcpy
	.globl	message
	.data
	.align 4
	.type	message, @object
	.size	message, 16
message:
	.string	"hello world!!!\n"
	.globl	buffer
	.bss
	.align 4
	.type	buffer, @object
	.size	buffer, 16
buffer:
	.zero	16
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	subl	$8, %esp
	pushl	$0
	call	time
	addl	$4, %esp
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$8, %esp
	movl	$100000000, (%esp)
	movl	(%esp), %eax
	movl	%eax, 4(%esp)
	jmp	.L6
.L7:
	pushl	$16
	pushl	$message
	pushl	$buffer
	call	memcpy
	addl	$12, %esp
.L6:
	movl	4(%esp), %eax
	leal	-1(%eax), %edx
	movl	%edx, 4(%esp)
	testl	%eax, %eax
	jne	.L7
	pushl	$0
	call	time
	addl	$4, %esp
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$8, %esp
	movl	(%esp), %eax
	movl	%eax, 4(%esp)
	jmp	.L8
.L9:
	pushl	$16
	pushl	$message
	pushl	$buffer
	call	amemcpy
	addl	$12, %esp
.L8:
	movl	4(%esp), %eax
	leal	-1(%eax), %edx
	movl	%edx, 4(%esp)
	testl	%eax, %eax
	jne	.L9
	pushl	$0
	call	time
	addl	$4, %esp
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$8, %esp
	movl	$0, %eax
	addl	$8, %esp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
