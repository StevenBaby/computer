
global memcpy
memcpy:
    ; void* memcpy( void *dest, const void *src, size_t count );
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 16]; count loop
    mov esi, [ebp + 12]; src
    mov edi, [ebp + 8]; dest

    cld
    rep movsb

    mov eax, [ebp + 8];
    leave
    ret


memcmp:
    ; int memcmp(const void* lhs, const void* rhs, size_t count );
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 16]
    mov esi, [ebp + 12]
    mov edi, [ebp + 8]

    cld
    repz cmpsb

    mov ecx, -1
    cmovb eax, ecx
    mov ecx, 1
    cmova eax, ecx
    mov ecx, 0
    cmovz eax, ecx

    leave
    ret

memset:
    ;void *memset(void *d1, int val, size_t len)
    push ebp
    mov ebp, esp

    pusha

    mov ecx, [ebp + 16]; len
    mov al, [ebp + 12]; val
    mov edi, [ebp + 8]; dest

    cld
    rep stosb

    mov eax, [ebp + 8]
    leave
    ret

memchr:
    ; void* memchr(void* ptr, int ch, std::size_t count );
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 16]; len
    mov al, [ebp + 12]; val
    mov edi, [ebp + 8]; dest

    cld
    repne scasb

    cmp ecx, 0
    jz .notfound

    mov eax, [ebp + 8] ; dest
    mov edx, [ebp + 16] ; len
    sub edx, ecx
    dec edx
    add eax, edx
    jmp .done

.notfound:
    mov eax, 0
    jmp .done
.done:
    leave
    ret

; section .text
; global main
; main:
;     push ebp
;     mov ebp, esp

;     push message.size
;     push message
;     push buffer
;     call amemcpy
;     add esp, 12 

;     leave
;     ret

; section .data

;     message db "hello world!!!", 10, 0
;     message.size equ ($-message)

; section .bss

;     buffer resb message.size

