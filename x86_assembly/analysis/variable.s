	.file	"variable.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp # 保存栈顶指针

	subl	$8, %esp # 在栈中预留8个字节

	movl	$0, -8(%ebp)  # int a = 0;
	movl	$5, -4(%ebp)  # int b = 5;

	movl	$0, %eax # return 0; 函数的返回值存储在 eax 寄存器中

	leave # 恢复栈顶指针
	ret # 函数返回
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
