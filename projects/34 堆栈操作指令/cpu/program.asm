
    mov ss, 1
    MOV SP, 0x10 ; [0, 0x9]
    mov D, 10;

    push D
    push 1

    pop C
    pop B
    MOV A, C;
    add a, b
    mov D, a;

    HLT
