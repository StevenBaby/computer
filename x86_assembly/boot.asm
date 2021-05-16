[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

offset equ 0x0000
data equ 0x55aa

mov ax, 0x1000
mov ds, ax

mov al, 0x10
mov ah, 0x10
mov ax, data

mov ax, [offset] ; 0x1000 * 0x10 + 0 = 0x100000
mov [offset], ax;

; dd 0xffeeffee

mov byte [offset], 0x10
mov word [offset], 0x10
mov dword [offset], 0xaa55eedd

; bx bp si di

mov ax, [bx];  [ds * 16 + bx]
mov ax, [bp]; [ss * 16 + bp]
mov ax, [si]; [ds * 16 + bp]
mov ax, [di]; [ds * 16 + bp]

mov ax, [bx + si + 0x100] ; ds
mov ax, [bp + si + 0x100] ; ss
mov ax, [bp + di + 0x100]

; mov ax, 0xb800
; mov es, ax

; mov ax, 0
; mov ds, ax

; mov si, message
; mov di, 0
; mov cx, (message_end - message)

; loop1:
;     mov al, [ds:si]
;     mov [es:di], al

;     ; add si, 1
;     inc si
;     add di, 2

;     loop loop1

halt:
    jmp halt

; message:
;     db "hello, world!!!", 0
; message_end:


times 510 - ($ - $$) db 0
db 0x55, 0xaa
