[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

mov ax, 0
mov cx, 100
start:
    ; jmp short start
    ; jmp near start
    ; jmp 0x0:0x7c00
    ; jmp far [goto]

    add ax, cx ; ax = ax + cx
    sub cx, 1
    jz end
    jmp start

end:

xchg bx, bx


halt:
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa

