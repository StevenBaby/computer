%use masm

section .data
    number dd 0x12345678

section .text
global main
main:
    mov ax, [number]
