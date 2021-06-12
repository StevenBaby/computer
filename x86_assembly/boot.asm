[org 0x7c00]

PIC_M_CMD equ 0x20
PIC_M_DATA equ 0x21

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00 ; 初始化堆栈

; xchg bx, bx ; bochs 断点

mov word [8 * 4], clock
mov word [8 * 4 + 2], 0

mov al, 0b1111_1110
out PIC_M_DATA, al

sti; IF = 1 set interrupt
; cli; clear interrupt
; clc; clear carry

loopa:
    mov bx, 3
    mov al, 'A'
    call blink
    jmp loopa


    ; 0x206; 0b0010_0000_0110;
clock:
    ; push flags
    ; push cs
    ; push ip
    ; 0x006; 0b0000_0000_0110

    ; xchg bx, bx
    push bx
    push ax

    mov bx, 4
    mov al, 'C'
    call blink

    mov al, 0x20
    out PIC_M_CMD, al

    pop ax
    pop bx
    iret

blink:
        push es
        push dx

        mov dx, 0xb800
        mov es, dx

        shl bx, 1
        mov dl, [es: bx]

        cmp dl, ' '
    jnz .set_space
    .set_char:
        mov [es:bx], al
        jmp .done
    .set_space:
        mov byte [es:bx], ' '
    .done:
        shr bx, 1

        pop dx
        pop es
        ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa
