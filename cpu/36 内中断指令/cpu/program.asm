
    mov ss, 1
    MOV SP, 0x20 ; [0, 0xf]
    jmp start

show:
    mov d, 255;
    iret; return;

start:
    mov c, 0

increase:
    inc c;
    mov d, c;
    JP disable
enable:
    sti;
    jmp interrupt
disable:
    cli

interrupt:
    int show
    jmp increase

    HLT
