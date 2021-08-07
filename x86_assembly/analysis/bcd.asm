section .data

    value1 dd 0x12345945
    value2 dd 0x03234098
    value3 dd 0

; 9,111,847

section .text
global main
main:
    clc
    mov ecx, 4
    xor edi, edi
loop1:
    mov al, [value1 + edi]
    sbb al, [value2 + edi]
    das
    mov [value3, + edi], al
    inc edi
    loop loop1

    ret