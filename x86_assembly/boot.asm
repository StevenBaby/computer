[org 0x7c00]

CRT_ADDR_REG equ 0x3D4
CRT_DATA_REG equ 0x3D5

CRT_CURSOR_HIGH equ 0x0E
CRT_CURSOR_LOW equ 0x0F

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00 ; 初始化堆栈

xchg bx, bx ; bochs 断点

mov ax, 0xb800
mov es, ax

mov si, message

print:
    call get_cursor
    mov di, ax
    shl di, 1

    mov bl, [si]
    cmp bl, 0
    jz print_end

    mov [es:di], bl

    inc si
    inc ax
    call set_cursor
    jmp print

print_end:

halt:
    hlt; 关闭 CPU，等待外中断的到来
    jmp halt

get_cursor:
    ; 获取光标位置，返回值存储在 AX 寄存器中

    push dx

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATA_REG
    in al, dx
    shl ax, 8

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATA_REG
    in al, dx

    pop dx

    ret

set_cursor:
    ; 设置光标位置，参数用 ax 传递
    push dx
    push bx

    mov bx, ax

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATA_REG
    mov al, bl
    out dx, al

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATA_REG
    mov al, bh
    out dx, al

    pop bx
    pop dx

    ret

message:
    db "hello, world!!!", 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
