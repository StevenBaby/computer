[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00 ; 初始化堆栈

xchg bx, bx ; bochs 断点

mov ax, 0x55aa; 0b_0101_0101_1010_1010
mov bx, 0xaa55; 0b_1010_1010_0101_0101
and ax, bx ; 0

and word [data], bx

mov ax, 0x55aa
or ax, bx; 0xffff

mov ax, 0x55aa
not ax ; 0xaa55

mov ax, 0xffff
xor ax, bx ; 55aa

xor ax, ax; ax 寄存器清零

mov ax, 0b1111_0010;
test ax, 0b0000_0010;
test ax, 0b0000_1000;

0x2 - 0b10
0x46 - 0b_0100_0110

xor ax, ax
mov al, 0b1010_1010
shl al, 3
shr al, 2

; 50 0b_0101_0000
; 14 0b_0001_0100

rol al, 4 ; 0100_0001
clc; 0_0100_0001
rcl al, 1; 0_1000_0010

halt:
    hlt; 关闭 CPU，等待外中断的到来
    jmp halt

data:
    dw 0x55aa

times 510 - ($ - $$) db 0
db 0x55, 0xaa
