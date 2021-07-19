	.file	"for.c"
	.text
	.globl	main
	.type	main, @function

main:
	pushl	%ebp
	movl	%esp, %ebp # 保存栈顶指针

	subl	$8, %esp # 预留局部变量空间

	movl	$0, -4(%ebp) # int sum = 0;
	movl	$1, -8(%ebp) # int i = 1; 

	jmp	.L2
.L3:
	movl	-8(%ebp), %eax # eax = i
	addl	%eax, -4(%ebp) # sum += eax
	addl	$1, -8(%ebp) # i += 1
.L2:
	cmpl	$9, -8(%ebp) # 9 - i
	jle	.L3

	# 设置返回值，恢复栈顶，返回
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
