
.PHONY: hello.s
hello.s: hello.c
	gcc -m32 -S -fno-asynchronous-unwind-tables -fno-pic -mpreferred-stack-boundary=2 -masm=intel -O0 $< -o $@
