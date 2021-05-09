[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

mov ax, 0xb800
mov es, ax

mov ax, 0
mov ds, ax

mov si, message
mov di, 0
mov cx, (message_end - message)

loop1:
    mov al, [ds:si]
    mov [es:di], al

    ; add si, 1
    inc si
    add di, 2

    loop loop1

halt:
    jmp halt

message:
    db "hello, world!!!", 0
message_end:


times 510 - ($ - $$) db 0
db 0x55, 0xaa
