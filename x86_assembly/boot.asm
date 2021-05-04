
mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

mov ax, 0x1111
mov bx, 0x2222
mov cx, 0x3333
mov dx, 0x4444
mov di, 0x5555
mov si, 0x6666
mov sp, 0x7777
mov bp, 0x8888

mov al, 0x3
mov ah, 0x4
mov bl, 0x5
mov bh, 0x6
mov cl, 0x7
mov ch, 0x8
mov dl, 0x9
mov dh, 0xa

; mov ax, 0xb800
; mov ds, ax

; mov byte [0], 'h'
; mov byte [2], 'e'
; mov byte [4], 'l'
; mov byte [6], 'l'
; mov byte [8], 'o'
; mov byte [10], ','
; mov byte [12], ' '
; mov byte [14], 'w'
; mov byte [16], 'o'
; mov byte [18], 'r'
; mov byte [20], 'l'
; mov byte [22], 'd'

halt:
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa
