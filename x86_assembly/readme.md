# x86 汇编语言

## 寄存器

| 寄存器 | 描述               |
| ------ | ------------------ |
| AX     | 累加结果数据       |
| BX     | 数据段数据指针     |
| CX     | 字符串和循环计数器 |
| DX     | I/O 指针           |
| DI     | 目的数据指针       |
| SI     | 源数据指针         |
| SP     | 栈指针             |
| BP     | 栈数据指针         |

| 寄存器 | 高八位 | 低八位 |
| ------ | ------ | ------ |
| AX     | AH     | AL     |
| BX     | BH     | BL     |
| CX     | CH     | CL     |
| DX     | DH     | DL     |

| 段寄存器 | 描述         |
| -------- | ------------ |
| CS       | 代码段寄存器 |
| DS       | 数据段寄存器 |
| SS       | 栈段寄存器   |
| ES       | 额外的寄存器 |

- IP
- FLAG / PSW

## 寻址方式

物理地址 = 段地址 * 16 + 偏移地址

16 $2^{16} = 64K$

1M $2^{20}$

20 - 16 = 4

段寄存器

偏移地址 + 段地址寄存器 = 32

12

段地址 << 4 + 偏移地址

## 标志寄存器

| 位  | 标志 | 英文      | 描述         |
| --- | ---- | --------- | ------------ |
| 0   | CF   | Carry     | 进位标志     |
| 1   |      |           |              |
| 2   | PF   | Parity    | 奇偶标志     |
| 3   |      |           |              |
| 4   | AF   | Auxiliary | 辅助进位标志 |
| 5   |      |           |              |
| 6   | ZF   | Zero      | 零标志       |
| 7   | SF   | Sign      | 符号标志     |
| 8   | TF   | Trap      | 陷阱标志     |
| 9   | IF   | Interrupt | 中断允许标志 |
| 10  | DF   | Direction | 方向标志     |
| 11  | OF   | Overflow  | 溢出标志     |


## 转移指令

8086 cs:ip 下一条指令的地址，物理地址 = cs << 4 + ip

jmp short start 占用两个字节，jmp 偏移数量，-128 - 127
jmp near start 占三个字节 -32768 - 32767
<!-- jmp far -->

8086 物理地址 = 段地址 << 4 + 偏移地址

64KB 内存空间

jmp far cs:ip

### 补码

负数的补码是原码取反再加一

x + 1 = 0 -> x = -1

0b1111_1111 = -1
0b1111_1110 = -2

f_e 0xfe
0b1111_1011 = 0xfb = -5


- JZ/JNZ : 结果为零/不为零则转移
- JS/JNS : 结果为负/为正则转移
- JO/JNO : 溢出/不溢出则转移
- JP/JNP : 奇偶位为1/为0则转移
- JB/JNB : 低于/不低于则转移
- JBE/JNBE : 低于等于/高于则转移
- JL/JNL : 小于/不小于则转移
- JLE/JNLE : 小于等于/大于则转移
- JCXZ : CX为零则转移

| 比较结果   | 英文                 | 指令 | 标志                |
| ---------- | -------------------- | ---- | ------------------- |
| 等于       | Equal                | je   | ZF = 1              |
| 不等于     | Not Equal            | jne  | ZF = 0              |
| 大于       | Greater              | jg   | ZF = 0 and SF = OF  |
| 大于等于   | Greater or Equal     | jge  | SF = 0F             |
| 不大于     | Not Greater          | jng  | ZF = 1 or SF != OF  |
| 不大于等于 | Not Greater or Equal | jnge | SF != OF            |
| 小于       | Less                 | jl   | SF != OF            |
| 小于等于   | Less or Equal        | jle  | ZF = 1 and SF != OF |
| 不小于     | Not Less             | jnl  | SF = OF             |
| 不小于等于 | Not Less or Equal    | jnle | ZF = 0 and SF = 0f  |
| 高于       | Above                | ja   | CF = 0 and ZF = 0   |
| 高于等于   | Above or Equal       | jae  | CF = 0              |
| 不高于     | Not Above            | jna  | CF = 1 or ZF = 1    |
| 不高于等于 | Not Above or Equal   | jnae | CF = 1              |
| 低于       | Below                | jb   | CF = 1              |
| 低于等于   | Below or Equal       | jbe  | CF = 1 or ZF = 1    |
| 不低于     | Not Below            | jnb  | CF = 0              |
| 不低于等于 | Not Below or Equal   | jnbe | CF = 0 and ZF = 0   |
| 偶         | Parity Even          | jpe  | PF = 1              |
| 奇         | Parity Odd           | jpo  | PF = 0              |


## 堆栈和函数

程序的指令的地址 cs:ip

栈顶的指针 ss:sp

push / pop
