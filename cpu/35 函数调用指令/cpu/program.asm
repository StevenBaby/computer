
    mov ss, 1
    MOV SP, 0x20 ; [0, 0xf]
    jmp start

show:
    mov d, 255;
    ret; return;

start:
    mov c, 0

increase:
    inc c;
    mov d, c;
    call show
    jmp increase

    HLT
