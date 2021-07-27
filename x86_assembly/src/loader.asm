[org 0x1000]

; xchg bx, bx

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
    ; xchg bx, bx

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

    call setup_page

    xchg bx, bx

    call load_kernel

    jmp code_selector: 0x11000

    jmp $

load_kernel:
    mov edi, 0x10000
    mov ecx, 10
    mov bl, 100
    call read_disk
    ret

PDE equ 0x2000
PTE equ 0x3000
ATTR equ 0b11

setup_page:
    mov eax, PDE
    call .clear_page
    mov eax, PTE
    call .clear_page

    ; 前面的 1M 内 前面的 1M
    ; 前面的 1M 映射到 0xC0000000 ~ 0xC0100000
    mov eax, PTE
    or eax, ATTR
    mov [PDE], eax; 
    ;0b_00000_00000_00000_00000_00000_00000_00
    mov [PDE + 0x300 * 4], eax;
    ;0b_11000_00000_00000_00000_00000_00000_00

    mov eax, PDE
    or eax, ATTR
    mov [PDE + 0x3ff * 4], eax; 吧最后一个页表指向了页目录

    mov ebx, PTE
    mov ecx, (0x100000 / 0x1000); 256
    mov esi, 0
    ; xchg bx, bx

.next_page:
    mov eax, esi
    shl eax, 12
    or eax, ATTR

    mov [ebx + esi * 4], eax
    inc esi
    loop .next_page

    ; xchg bx, bx
    mov eax, PDE
    mov cr3, eax

    mov eax, cr0
    or eax, 0b1000_0000_0000_0000_0000_0000_0000_0000
    mov cr0, eax

    ret

.clear_page:
    ; 清空一个内存页，地址参数存在 eax 中
    mov ecx, 0x1000
    mov esi, 0
.set:
    mov byte [eax + esi], 0
    inc esi
    loop .set
    ret

read_disk:
    ; 读取硬盘
    ; edi - 存储内存位置
    ; ecx - 存储起始的扇区位置
    ; bl - 存储扇区数量
    pushad; ax, cx, dx, bx, sp, bp, si, di
    ; pushad; ax, cx, dx, bx, sp, bp, si, di

    mov dx, 0x1f2
    mov al, bl
    out dx, al; 设置扇区数量

    mov al, cl
    inc dx; 0x1f3
    out dx, al; 起始扇区位置低八位

    shr ecx, 8
    mov al, cl
    inc dx; 0x1f4
    out dx, al; 起始扇区位置中八位

    shr ecx, 8
    mov al, cl
    inc dx; 0x1f5
    out dx, al; 起始扇区位置高八位

    shr ecx, 8
    and cl, 0b1111

    inc dx; 0x1f6
    mov al, 0b1110_0000
    or al, cl
    out dx, al

    inc dx; 0x1f7
    mov al, 0x20; 读硬盘
    out dx, al

    xor ecx, ecx
    mov cl, bl

.read:
    push cx
    call .waits
    call .reads
    pop cx 
    loop .read

    popad
    ; popa

    ret


.waits:
    mov dx, 0x1f7
    .check:
        nop
        nop
        nop ; 一点延迟

        in al, dx
        and al, 0b1000_1000
        cmp al, 0b0000_1000
        jnz .check
    ret

.reads:
    mov dx, 0x1f0
    mov cx, 256; 一个扇区 256 个字
    .readw:
        nop
        nop
        nop

        in ax, dx
        mov [edi], ax
        add edi, 2

        loop .readw
    ret

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
