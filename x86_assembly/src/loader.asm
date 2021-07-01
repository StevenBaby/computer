[org 0x1000]

xchg bx, bx

check_memory:
    mov ax, 0
    mov es, ax
    xor ebx, ebx
    mov edx, 0x534d4150
    mov di, ards_buffer

.next:
    mov eax, 0xE820
    mov ecx, 20
    int 0x15

    jc .error

    add di, cx
    inc word [ards_count]
    cmp ebx, 0
    jnz .next

    jmp prepare_protect_mode

;     xchg bx, bx

;     mov cx, [ards_count]
;     mov si, 0
; .show:
;     mov eax, [si + ards_buffer]
;     mov ebx, [si + ards_buffer + 8]
;     mov edx, [si + ards_buffer + 16]
;     add si, 20
;     xchg bx, bx
;     loop .show

.error:
    mov ax, 0xb800
    mov es, ax
    mov byte [es:0], 'E'
    jmp $


prepare_protect_mode:
    xchg bx, bx

    cli ; 关闭中断

    ; 打开 A20 线
    in al, 0x92
    or al, 0b10
    out 0x92, al

    lgdt [gdt_ptr]; 加载 gdt

    mov eax, cr0; 启动保护模式
    or eax, 1
    mov cr0, eax

    jmp dword code_selector:protect_enable

    ud2; 出错

[bits 32]
protect_enable:

    mov ax, data_selector
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax; 初始化数据段

    mov esp, 0x10000

    mov ax, test_selector
    mov gs, ax

    xchg bx, bx

    mov word [gs:0], 0x55aa

    xchg bx, bx

    mov word [gs:0x2000], 0x55aa

    xchg bx, bx

    jmp $

code_selector equ (1 << 3)
data_selector equ (2 << 3)
test_selector equ (3 << 3)

gdt_ptr:
    dw (gdt_end - gdt_base - 1)
    dd gdt_base

gdt_base:
    dd 0, 0
gdt_code:
    dw 0xffff;
    dw 0
    db 0;
    db 0b1001_1110
    db 0b1100_1111
    db 0
gdt_data:
    dw 0xffff;
    dw 0
    db 0
    db 0b1001_0010
    db 0b1100_1111
    db 0
gdt_test:
    dw 0xfff
    dw 0x0000
    db 0x1
    db 0b1001_0010 ;0x92
    db 0b0100_0000 ; 0x40
    db 0x0
gdt_end:

ards_count:
    dw 0
ards_buffer:
