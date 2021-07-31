[bits 32]

section .data

value:
    dd 0; 0
    dd 43.65; 1
    dd 22;
    dd 76.34
    dd 3.1
    dd 12.43; 5
    dd 6;
    dd 140.2;
    dd 94.21; 8
output:
    db "result = %f", 10, 0

extern printf

section .text
global main
main:
    finit ; 初始化浮点控制寄存器

    fld dword [value + 4 * 1]; 加载一个浮点数
    fidiv dword [value + 4 * 2]; 除一个整数

    fld dword [value + 4 * 3]
    fld dword [value + 4 * 4]
    fmul st0, st1
    fadd st0, st2

    fld dword [value + 4 * 5]
    fimul dword [value + 4 * 6]

    fld dword [value + 4 * 7]
    fld dword [value + 4 * 8]
    fdivp

    fsubr st0, st1
    fdivr st0, st2

    sub esp, 8
    fstp qword [esp]
    push output
    call printf
    add esp, 12

    ret
