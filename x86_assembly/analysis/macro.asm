; %include "macro.inc"

; %define square(x) (x * x)
; %define add(x, y) (x + y)

; base
; limit
; type
; segment
; dpl
; present
; long_mode
; big
; granularity

%macro descriptor 9
    dw %2 & 0xffff
    dw %1 & 0xffff
    db (%1 >> 16) & 0xff
    db %3 | (%4 << 4) | (%5 << 6) | (%6 << 7)
    db ((%2 >> 16) & 0xf) | (%7 << 5) | (%8 << 6) | (%9 << 7)
    db (%1 >> 24) & 0xff
%endmacro

descriptor 0x10000, 0xfff, 0b0010, 1, 0, 1, 0, 1, 0

; section .text
; global main
; main:
;     mov eax, square(10)
;     mov ebx, add(5, 3)
;     ret
