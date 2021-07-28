#include "compile.h"

void function()
{
}

int main(int argc, char const *argv[])
{
    function();

    asm volatile(
        "movl $1, %eax\n"
        "movl $0, %ebx\n"
        "int $0x80\n"
    );

    return 0;
}
