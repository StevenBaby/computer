
CFLAGS:= -m32 \
		 -O0 \
		 -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -mpreferred-stack-boundary=2 \
		 -fno-stack-protector \
		 -fno-builtin \


.PHONY: hello.s
hello.s: hello.c
	gcc $(CFLAGS) -S $< -o $@


.PHONY: variable.s
variable.s: variable.c
	gcc $(CFLAGS) -S $< -o $@


.PHONY: test.s
test.s: test.c
	gcc $(CFLAGS) -S $< -o $@

%.s: %.c
	gcc $(CFLAGS) -S $< -o $@
