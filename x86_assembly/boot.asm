[org 0x7c00]

mov ax, 3
int 0x10 ; 将显示模式设置成文本模式

xchg bx, bx

; mov ax, 5
; mov bx, 6
; add ax, bx; ax = ax + bx

; add word [number], 5

; sub ax, bx

; mov ax, 0xffff
; mov bx, 5
; add ax, bx

mov ax, 5
mov bx, 7
mul bx; dx : ax = bx * ax

; dx : ax / oper = ax 商 - dx 余数

mov bx, 4
div bx
; ax 8, dx - 3

; 异常

; adc
; 16 

clc;

mov ax, [number1]
mov bx, [number2]
add ax, bx
mov [sum], ax

mov ax, [number1 + 2]
mov bx, [number2 + 2]
adc ax, bx
mov [sum + 2], ax

; sbb

; 82 1000_0010
; 13 0001_0011

halt:
    jmp halt

; number:
;     dw 0x3456

number1:
    dd 0xcfff_ffff
number2:
    dd 4
sum:
    dd 0x0000_0000

times 510 - ($ - $$) db 0
db 0x55, 0xaa
