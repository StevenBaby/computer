; MOV C, 5;

; MOV D, C;

; MOV D, [5];

; MOV A, 6;

; MOV D, [A]


; MOV [0x2f], 5;

; MOV C, 0x18;
; MOV [0x2f], C;

; MOV [0x2e], 18;

; MOV [0x2f], [0x2e];

; MOV [0x18], 0xfe

; MOV C, 0x18;

; MOV D, 0x33;

; MOV [C], D;


MOV [0x30], 0xee;


MOV D, 0x30

MOV C, 0x18;

MOV [C], [0x30];

hlt;
