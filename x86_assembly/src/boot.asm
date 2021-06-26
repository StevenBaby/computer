[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00 ; 初始化堆栈

; xchg bx, bx ; bochs 断点

mov edi, 0x1000
mov ecx, 2
mov bl, 4
call read_disk

; xchg bx, bx;

jmp 0:0x1000; 跳转到 loader

; 0 -> 0x1000

read_disk:
    ; 读取硬盘
    ; edi - 存储内存位置
    ; ecx - 存储起始的扇区位置
    ; bl - 存储扇区数量
    pushad; ax, cx, dx, bx, sp, bp, si, di
    ; pushad; ax, cx, dx, bx, sp, bp, si, di

    mov dx, 0x1f2
    mov al, bl
    out dx, al; 设置扇区数量

    mov al, cl
    inc dx; 0x1f3
    out dx, al; 起始扇区位置低八位

    shr ecx, 8
    mov al, cl
    inc dx; 0x1f4
    out dx, al; 起始扇区位置中八位

    shr ecx, 8
    mov al, cl
    inc dx; 0x1f5
    out dx, al; 起始扇区位置高八位

    shr ecx, 8
    and cl, 0b1111

    inc dx; 0x1f6
    mov al, 0b1110_0000
    or al, cl
    out dx, al

    inc dx; 0x1f7
    mov al, 0x20; 读硬盘
    out dx, al

    xor ecx, ecx
    mov cl, bl

.read:
    push cx
    call .waits
    call .reads
    pop cx 
    loop .read

    popad
    ; popa

    ret


.waits:
    mov dx, 0x1f7
    .check:
        nop
        nop
        nop ; 一点延迟

        in al, dx
        and al, 0b1000_1000
        cmp al, 0b0000_1000
        jnz .check
    ret

.reads:
    mov dx, 0x1f0
    mov cx, 256; 一个扇区 256 个字
    .readw:
        nop
        nop
        nop

        in ax, dx
        mov [edi], ax
        add edi, 2

        loop .readw
    ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa
