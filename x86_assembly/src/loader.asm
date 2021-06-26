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

    xchg bx, bx

    mov cx, [ards_count]
    mov si, 0
.show:
    mov eax, [si + ards_buffer]
    mov ebx, [si + ards_buffer + 8]
    mov edx, [si + ards_buffer + 16]
    add si, 20
    xchg bx, bx
    loop .show

.error:

jmp $

ards_count:
    dw 0
ards_buffer:
