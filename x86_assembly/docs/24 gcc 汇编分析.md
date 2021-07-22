# gcc 汇编分析


## CFI 

Call Frame Information 调用栈帧信息

`.cfi_` 用于调试的信息，可以在调用失败的时候回溯栈。

A --> B --> C (异常)

    -fno-asynchronous-unwind-tables


## PIC

Position Independent Code / 位置无关的代码

动态链接

    mov eax, eip;

上面这条指令是无效的。调用了 `__x86.get_pc_thunk.ax` 函数来获取 `eip` 的值。

    -fno-pic

## 栈对齐

-16 = 0 - 16 = 0x00000000 - 0x10 = 0xfffffff0

0b1{28}0000

    andl	$-16, %esp

将栈对齐到 16 字节

    -mpreferred-stack-boundary=2

## Intel

    -masm=intel

## 代码

```s
main:
	push	ebp ;
	mov	ebp, esp ; 保存栈顶指针

	push	OFFSET FLAT:.LC0 ; 传递参数
	call	puts ; 调用
	add	esp, 4 ; 调用之后恢复栈

	mov	eax, 0; 返回值，存在 eax 寄存器中

	leave
    # mov esp, ebp
    # pop ebp
	ret
```
