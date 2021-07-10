# ELF 文件格式简介

Executable and Linking Format / 可执行和链接的格式

- 可执行程序 python / bash / gcc --> PE (.exe)
- 可重定位文件 / 静态库 / gcc -c `.o` --> .o.a / .lib
- 共享的目标文件 / 动态链接库 --> .so/.dll

----

C 语言 --> 汇编

- 代码 .text
- 数据
    - .data / 已经初始化过的数据
    - .bss / 未初始化的数据 - buffer 缓存区域

---
    readelf -e file.o

---
    objdump -d a.out

PIE - Position Independent Executable

Intel / AT&T

gas GNU AT&T
