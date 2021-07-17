	.file	"variable.c"
	.text
	.globl	add
	.type	add, @function
add:
	pushl	%ebp
	movl	%esp, %ebp # 保存栈顶指针

	subl	$4, %esp # 预留栈空间 int c;

	movl	8(%ebp), %edx # a
	movl	12(%ebp), %eax # b

	addl	%edx, %eax # 执行加法

	movl	%eax, -4(%ebp) # 给 c 赋值

	movl	-4(%ebp), %eax # 函数的返回值存储在 eax 寄存器中

	leave # 恢复栈顶指针和返回
	ret

	.size	add, .-add
	.section	.rodata
.LC0:
	.string	"%d + %d = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp # 保存栈顶指针

	subl	$12, %esp # 为局部变量留栈内存空间

	movl	$5, -4(%ebp) # int i = 5;
	movl	$10, -8(%ebp) # int j = 10;

	pushl	-8(%ebp) # push j
	pushl	-4(%ebp) # push i

	call	add # 调用

	addl	$8, %esp # 恢复栈 

	movl	%eax, -12(%ebp) # int k = add(i, j);
	pushl	-12(%ebp) # k
	pushl	-8(%ebp) # j
	pushl	-4(%ebp) # i
	pushl	$.LC0 # "%d + %d = %d\n

	call	printf # 调用

	addl	$16, %esp # 恢复栈

	movl	$0, %eax # 函数返回值

	leave # 恢复栈顶指针
	ret # 函数返回
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
