# 0 "compile.cc"
# 1 "/home/steven/source/github/computer/x86_assembly/analysis//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "compile.cc"
# 1 "compile.h" 1

void function();
# 2 "compile.cc" 2

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
