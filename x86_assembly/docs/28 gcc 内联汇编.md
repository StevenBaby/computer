# gcc 内联汇编

## 基础内联汇编

```cpp
#include <stdio.h>

int main()
{
    asm("movl $1, %eax\n movl $0, %ebx\n int $0x80");
}
```

```cpp
#include <stdio.h>

int main()
{
    asm(
        "movl $1, %eax\n"
        "movl $0, %ebx\n"
        "int $0x80\n");
}
```

## 使用全局变量

```cpp
#include <stdio.h>

int a = 10;
int b = 20;
int result;

int main()
{
    // result = a + b;
    asm(
        "movl a, %eax\n"
        "movl b, %edx\n"
        "addl %edx, %eax\n"
        "movl %eax, result");

    printf("%d + %d = %d\n", a, b, result);
}
```

## 扩展内联汇编 / 使用局部变量

```cpp
asm ("assembly code": output : input : changed registers)
```

```cpp
"constraint"(variable)
```

| 约束 | 描述                                 |
| ---- | ------------------------------------ |
| a    | 使用 eax 及相关寄存器                |
| b    | 使用 ebx 及相关寄存器                |
| c    | 使用 ecx 及相关寄存器                |
| d    | 使用 edx 及相关寄存器                |
| S    | 使用 esi 及相关寄存器                |
| D    | 使用 edi 及相关寄存器                |
| r    | 使用任何可用的通用寄存器             |
| q    | 使用 eax,ebx,ecx,edx 之一            |
| A    | 对于 64 位值使用 eax 和 edx 寄存器   |
| f    | 使用浮点寄存器                       |
| t    | 使用第一个（顶部的）浮点寄存器       |
| u    | 使用第二个浮点寄存器                 |
| m    | 使用变量的内存位置                   |
| o    | 使用偏移的内存位置                   |
| V    | 只使用直接内存位置                   |
| i    | 使用立即数整型                       |
| n    | 使用值已知的立即数整型               |
| g    | 使用任何可用的寄存器或者任何内存位置 |

| 输出修饰符 | 描述                                   |
| ---------- | -------------------------------------- |
| +          | 可以读取和写入操作数                   |
| =          | 只能写入操作数                         |
| %          | 如果必要，操作数可以和下一个操作数切换 |
| &          | 相关的寄存器只能用于输出               |

扩展汇编中寄存器需要两个 %

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result;

    // result = a + b;
    asm volatile(
        "addl %%edx, %%eax\n"
        : "=a"(result)
        : "a"(a), "d"(b));

    printf("%d + %d = %d\n", a, b, result);
}
```

## 占位符

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result;

    // result = a + b;
    asm volatile(
        "addl %1, %2\n"
        "movl %2, %0\n"
        : "=r"(result) // %0
        : "r"(a), "r"(b));

    printf("%d + %d = %d\n", a, b, result);
}
```

## 引用占位符

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result = 30;

    // result = result + a;
    // result = a + b;
    asm volatile(
        "addl %1, %2\n"
        "movl %2, %0\n"
        : "=r"(result) // %0
        : "r"(a), "0"(result));

    // printf("%d + %d = %d\n", a, b, result);
    printf("result + %d = %d\n", a, result);
}
```

## 命名的占位符

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result;

    // result = a + b;
    asm volatile(
        "addl %[var2], %[var3]\n"
        "movl %[var3], %[var1]\n"
        : [var1] "=r"(result) // %0
        : [var2] "r"(a), [var3] "r"(b));

    printf("%d + %d = %d\n", a, b, result);
}
```

## 改动的寄存器列表

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result;

    // result = a + b;
    asm volatile(
        "movl %[a], %%eax\n"
        "movl %[b], %%edx\n"
        "addl %%edx, %%eax\n"
        "movl %%eax, %[result]\n"
        : [result] "=r"(result) // %0
        : [a] "r"(a), [b] "r"(b)
        : "%eax", "%edx");

    printf("%d + %d = %d\n", a, b, result);
}
```

## 使用内存位置

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result;

    // result = a + b;
    asm volatile(
        "addl %[var2], %[var3]\n"
        "movl %[var3], %[var1]\n"
        : [var1] "=m"(result) // %0
        : [var2] "m"(a), [var3] "m"(b));

    printf("%d + %d = %d\n", a, b, result);
}
```

## earlyclobber

```cpp
#include <stdio.h>

int main()
{
    int a = 10;
    int b = 20;
    int result = 30;

    // result = a + b;
    asm volatile(
        "movl $10, %0\n"
        "movl $20, %1\n"
        : "=&r"(a) // %0
        : "r"(b));

    printf("%d + %d = %d\n", a, b, result);
}
```
