section .data

    value1 dd 3.49
    value2 dd 4.0

message:
    db "%f %s %f", 10, 0
sg:
    db ">", 0
sl:
    db "<=", 0

extern printf

section .text
global main
main:
    finit

    fld dword [value1]
    fld dword [value2]

    ; 0x3000
    ; 0x3100

    ; 0b_0_0_11_0000
    ; 0b_0_0_11_0001

    ; fcom
    ; fstsw ax
    ; sahf; 将 ah 寄存器中的值传送到 flag

    fcomi

    jc .greater
.less:
    sub esp, 8
    fstp qword [esp]
    push sl
    sub esp, 8
    fstp qword [esp]
    push message 
    call printf
    ; printf(message, st1, <= , st0);
    add esp, 24
    jmp .done
.greater:
    sub esp, 8
    fstp qword [esp]
    push sg
    sub esp, 8
    fstp qword [esp]
    push message 
    call printf
    ; printf(message, st1, > , st0);
    add esp, 24

.done:
    ret