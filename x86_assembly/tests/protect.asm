[bits 32]

extern exit

section .text
global main
main:
    ; mov eax, cr0; 寄存器的保护

    ; in al, 0x92;

    push 0
    call exit



