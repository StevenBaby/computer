
CFLAGS:= -m32 \
		 -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -mpreferred-stack-boundary=2 \
		-O0

.PHONY: hello.s
hello.s: hello.c
	gcc $(CFLAGS) -S $< -o $@


.PHONY: variable.s
variable.s: variable.c
	gcc $(CFLAGS) -S $< -o $@
