[bits 32]

section .text

global _start
_start:
    mov eax, 4; write
    mov ebx, 1; stdout
    mov ecx, message; buffer
    mov edx, message_end - message
    int 0x80

    mov eax, 1; exit
    mov ebx, 0; status
    int 0x80

section .data
    message db "hello world!!!", 10, 13, 0
    message_end:

section .bss
    resb 0x100 ; 预留 0x100 字节的空间
    ; resw 0x100 ; 预留 0x100 字的空间
    ; resd 0x100 ; 预留 0x100 双字的空间
    ; resq 0x100 ; 预留 0x100 四字的空间
