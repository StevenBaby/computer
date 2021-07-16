# AT&T 语法格式

C --> 汇编  
gas 伪指令

--- 

> AT&T 默认数内存地址

## 立即数

立即数前面要加 `$`

    $123 #
    123

    mov dword eax, message
    movl $message, %eax

# 寄存器

寄存器前要加上 `%`


## 数据传送指令

    movx source, destination

数据的传送方向是从左向右的。

    movl %eax, %ebx

等价于，Intel 语法：

    mov ebx, eax

| movx | 描述  | Intel     |
| ---- | ----- | --------- |
| movl | 32 位 | mov dword |
| movw | 16 位 | mov word  |
| movb | 8 位  | mov byte  |

## 数据类型

| 命令      | 数据类型                | nasm   |
| --------- | ----------------------- | ------ |
| `.ascii`  | 字符串                  | `db`   |
| `.asciz` | 以 `\0` 结尾的字符串    | `db 0` |
| `.byte`   | 字节                    | `db`   |
| `.double` | 双精度浮点              | `dq`   |
| `.float`  | 单精度浮点              | `dd`   |
| `.int`    | 32位整数                | `dd`   |
| `.long`   | 32位整数和(`.int` 相同) | `dd`   |
| `.octa`   | 16字节整数              |        |
| `.quad`   | 8字节整数               | `dq`   |
| `.short`  | 16位整数                | `dw`   |
| `.single` | 单精度浮点              | `dd`   |

只针对汇编器，伪指令。

## 伪指令

节定义 `.section`；段，`segment  = section + ... + section`

代码段 `.text` 数据段 `.data` bss 段 `.bss`

BSS Block Started Symbol; `resb`

| 命令     | 描述                              |
| -------- | --------------------------------- |
| `.comm`  | 通用缓存区域                      |
| `.lcomm` | 本地缓存区域 (只本文件可用的区域) |

## 寻址方式

> [offset_address + index * size + base_address] ; 32 bit

> base_address(offset_address, index, size)

offset_address, index 必须是寄存器，size 1, 2, 4, 8

```s
movl %edx, 4(%edi, %eax, 8) # att 语法
mov dword [edi + eax * 8 + 4] ; Intel 语法
```