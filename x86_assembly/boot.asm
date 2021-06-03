[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00

mov word [0x80 * 4], print
mov word [0x80 * 4 + 2], 0

mov word [0 * 4], divide_error
mov word [0 * 4 + 2], 0

mov dx, 0
mov ax, 1
mov bx, 0
div bx

; dx:ax / bx 

; int 0x80
; call 0:print; callf
; call far [function]

halt:
    jmp halt

print:
    push ax
    push bx
    push es

    mov ax, 0xb800
    mov es, ax
    mov bx, [video]
    mov byte [es:bx], '.'
    add word [video], 2

    pop es
    pop bx
    pop ax

    ;ret ; pop ip
    ; retf; pop ip; pop cs
    iret; pop ip; pop cs ; pop flags

    ; interrupt return

divide_error:
    push ax
    push bx
    push es

    mov ax, 0xb800
    mov es, ax
    mov bx, [video]
    mov byte [es:bx], '/'
    add word [video], 2

    pop es
    pop bx
    pop ax

    hlt
    ; xchg bx, bx
    ;ret ; pop ip
    ; retf; pop ip; pop cs
    iret; pop ip; pop cs ; pop flags

    ; interrupt return

function:
    dw print, 0

video:
    dw 0x0

times 510 - ($ - $$) db 0
db 0x55, 0xaa

