# x86 汇编语言

## 参考资料

[参考资料](./参考资料.md)

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


## 内中断和异常

远调用

jmp short start 占用两个字节，jmp 偏移数量，-128 - 127
jmp near start 占三个字节 -32768 - 32767
jmp far

call function; push ip ; jmp function
call far function; push cs; push ip; jmp function
<!-- cs ip 64KB -->

内中断

### 内存布局

| 起始地址  | 结束地址  | 大小     | 用途               |
| --------- | --------- | -------- | ------------------ |
| `0x000`   | `0x3FF`   | 1KB      | 中断向量表         |
| `0x400`   | `0x4FF`   | 256B     | BIOS 数据区        |
| `0x500`   | `0x7BFF`  | 29.75 KB | 可用区域           |
| `0x7C00`  | `0x7DFF`  | 512B     | MBR 加载区域       |
| `0x7E00`  | `0x9FBFF` | 607.6KB  | 可用区域           |
| `0x9FC00` | `0x9FFFF` | 1KB      | 扩展 BIOS 数据区   |
| `0xA0000` | `0xAFFFF` | 64KB     | 用于彩色显示适配器 |
| `0xB0000` | `0xB7FFF` | 32KB     | 用于黑白显示适配器 |
| `0xB8000` | `0xBFFFF` | 32KB     | 用于文本显示适配器 |
| `0xC0000` | `0xC7FFF` | 32KB     | 显示适配器 BIOS    |
| `0xC8000` | `0xEFFFF` | 160KB    | 映射内存           |
| `0xF0000` | `0xFFFEF` | 64KB-16B | 系统 BIOS          |
| `0xFFFF0` | `0xFFFFF` | 16B      | 系统 BIOS 入口地址 |

0x000 - 0x3ff -> 0x400

4B

0x400 / 4 = 0x100 -> 256

0 - 255

0 除法异常 0 - 3

0x80 * 4, 0x80 * 4 + 3

0x80 linux 系统调用，软中断


## 逻辑运算指令

- AND - TEST / SUB - CMP
- OR
- NOT
- XOR

- SHL / SHR
- ROL / ROR
- RCL / RCR


## 输入和输出

输入输出指令，来控制硬件（外围设备）

- 显示器 - 显卡
- 硬盘
- 键盘

端口 / 映射内存，

寄存器 / D 边沿触发器

Intell 0-65535 0x0000 ~ 0xffff

阴极射线管控制器

CRT 地址端口 0x3D4 
CRT 数据端口 0x3D5

80 * 25 = 2000

16 位 / 8 位

16K 字符

0 - 1999

0x0E - 光标位置高八位
0x0F - 光标位置第八位

```s
in al, dx; dx 端口号
in ax, dx; ax/al 数
out dx, al;
out dx, ax;
```

ax 16 , al 8

## 控制字符样式

- ASCII 码
- 字符样式

-- 

- 高四位表示背景色 | K | R | G | B |
- 低四位表示前景色 | I | R | G | B |

---

- K = 0 : 背景不闪烁
- K = 1 : 背景闪烁
- I = 0 : 深色字符
- I = 1 : 浅色字符

---

| Red | Green | Blue | Color   | 说明      |
| --- | ----- | ---- | ------- | --------- |
| 0   | 0     | 0    | Black   | 黑色      |
| 0   | 0     | 1    | Blue    | 蓝色      |
| 0   | 1     | 0    | Green   | 绿色      |
| 0   | 1     | 1    | Cyan    | 青色      |
| 1   | 0     | 0    | Red     | 红色      |
| 1   | 0     | 1    | Magenta | 洋红      |
| 1   | 1     | 0    | Yellow  | 黄色      |
| 1   | 1     | 1    | White   | 白色/灰色 |

## 外中断和时钟

- 内中断和异常
- 输入和输出

---

CPU ---> 硬件，端口

- 键盘
- 鼠标

---

- 时钟信号/脉冲 - CPU 的脉搏
- 时钟中断 - OS 的脉搏

---

8086

- NMI Non Maskable Interrupt / 不可屏蔽中断
- INTR Interrupt / 可屏蔽中断

----

8259 - 可编程中断控制器 / PIC Programmable Interrupt Controller

- 主芯片 - 8 1
- 从芯片 - 8 
- 级联方式


### 中断向量表

| 向量 | 功能            |
| ---- | --------------- |
| 0    | 除法溢出        |
| 1    | 单步 (用于调试) |
| 2    | 非屏蔽中断 NMI  |
| 3    | 断点 (用于调试) |
| 4    | 溢出中断        |
| 5    | 打印屏幕        |
| 6-7  | 保留            |
| 8    | 时钟            |
| 9    | 键盘            |
| A    | 保留            |
| B    | 串行通信COM2    |
| C    | 串行通信COM1    |
| D    | 保留            |
| E    | 软盘控制器      |
| F    | 并行打印机      |

| 端口 | 说明            | 标记       |
| ---- | --------------- | ---------- |
| 0x20 | 主 PIC 命令端口 | PIC_M_CMD  |
| 0x21 | 主 PIC 数据端口 | PIC_M_DATA |
| 0xA0 | 从 PIC 命令端口 | PIC_S_CMD  |
| 0xA1 | 从 PIC 数据端口 | PIC_S_DATA |

- ICW1 ~ ICW4 用于初始化 8259 initialization Command Words
- OCW1 ~ OCW3 用于操作 8259 Operation Commands Words

---

- 向 OCW1 写入屏蔽字，打开时钟中断
- sti 设置 CPU 允许外中断
- 向 OCW2 写入 0x20, 表示中断处理完毕

中断向量表

中断函数指针数组

- IF / CPU 的外中断开关
- MASK 中断屏蔽开关 / 8259 总开关
- 执行中的开关

- <https://wiki.osdev.org/8259_PIC>
- <https://pdos.csail.mit.edu/6.828/2005/readings/hardware/8259A.pdf>
