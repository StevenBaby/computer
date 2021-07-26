[bits 32]

extern printf

section .text
global add
add:
    push ebp
    mov ebp, esp

    push message
    call printf
    add esp, 4

    ; ebp ; ebp + 0
    ; eip ; ebp + 4
    ; a ; ebp + 8
    ; b ; ebp + 12

    mov eax, [ebp + 8]; eax = a
    add eax, [ebp + 12]; b

    leave
    ret

global sub
sub:
    push ebp
    mov ebp, esp

    mov eax, ecx
    sub eax, edx

    leave
    ret

section .data

    message db "add called!!!", 10, 0
