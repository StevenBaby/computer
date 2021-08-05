section .data

    value1 dd 3.49
    value2 dd 4.0
    value3 dd 0.5

    value4 dd 19.8
    value5 dd 3.4


section .text
global main
main:
    finit

    ; fld1
    ; fldl2t
    ; fldl2e
    ; fldpi
    ; fldlg2
    ; fldln2
    ; fldz

    ; fldpi
    ; frndint

    ; fldpi
    ; fchs ; change sign
    ; frndint

    ; fld dword [value1]
    ; frndint ; 四舍五入

    ; fabs ; 

    ; fld dword [value2]
    ; fsqrt ; square root

    ; fldpi
    ; fsin

    ; fldpi
    ; fcos

    ; fldpi
    ; fsincos

    ; fldpi
    ; fptan

    ; fld1
    ; fld1
    ; fpatan

    ; fld dword [value3]
    ; f2xm1

    fld dword [value5]
    fld dword [value4]
    fprem

    fld dword [value5]
    fld dword [value4]
    fprem1

    ret