# BCD 码及其运算

Binary Coded Decimal / 二进制编码的十进制数

int ; // 除十取余

char number[10000]; // 0x30 + 0 = 0 0x31 

- 不打包的 BCD 码 / 一个字节表示一个十进制位
- 打包的 BCD 码 / 一个字节表示两个十进制位

## 运算

- AAA: 调整加法操作的结果
- AAS: 调整减法操作的结果
- AAM: 调整乘法操作的结果
- AAD: 准备除法操作的被除数

## 加法

```s
section .data

    value1 dd 0x05060708
    value2 dd 0x01020304
    value3 dd 0

; 6912

section .text
global main
main:
    clc
    mov ecx, 4
    xor edi, edi
loop1:
    mov al, [value1 + edi]
    adc al, [value2 + edi]
    aaa
    mov [value3, + edi], al
    inc edi
    loop loop1

    ret
```

## 减法

```s
section .data

    value1 dd 0x05060708
    value2 dd 0x03090809
    value3 dd 0

; 1689

section .text
global main
main:
    clc
    mov ecx, 4
    xor edi, edi
loop1:
    mov al, [value1 + edi]
    sbb al, [value2 + edi]
    aas
    mov [value3, + edi], al
    inc edi
    loop loop1

    ret
```

## 乘法和除法

```s
section .data

    value1 dd 0x05060708
    value2 dd 0x03090809
    value3 dd 0

; 1689

section .text
global main
main:

    mov al, [value1]
    mul byte [value2]
    aam

    mov ax, [value1]
    aad
    div byte [value2]

    ret
```

## 打包的 BCD 码

DAA: 调整 ADD 或者 ADC 指令的结果。
DAS: 调整 SUB 或者 SBB 指令的结果。


```s
section .data

    value1 dd 0x12345678
    value2 dd 0x12345678
    value3 dd 0

; 24,691,356

section .text
global main
main:
    clc
    mov ecx, 4
    xor edi, edi
loop1:
    mov al, [value1 + edi]
    adc al, [value2 + edi]
    daa
    mov [value3, + edi], al
    inc edi
    loop loop1

    ret
```

```s
section .data

    value1 dd 0x12345945
    value2 dd 0x03234098
    value3 dd 0

; 9,111,847

section .text
global main
main:
    clc
    mov ecx, 4
    xor edi, edi
loop1:
    mov al, [value1 + edi]
    sbb al, [value2 + edi]
    das
    mov [value3, + edi], al
    inc edi
    loop loop1

    ret
```

## AF 标记

用于调整打包的 BCD 码
