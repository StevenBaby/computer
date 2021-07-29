[bits 32]

section .text
global main
main:
    ; mov al, 1

    ; mov ebx, al
    ; mov ebx, 0
    ; xor ebx, ebx
    ; mov bl, al

    ; movzx ebx, al

    ; mov al, -1; 0xff

    ; movsx ebx, al; 0xffffffff

    ; mov al, 0xff; -1
    ; add al, 1; 0 

    mov al, 127;
    inc al

    ret