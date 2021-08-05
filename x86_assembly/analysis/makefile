
CFLAGS:= -m32 \
		 -O0 \
		 -static \
		 -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -mpreferred-stack-boundary=2 \
		 -fno-stack-protector \
		 -fno-builtin \
		 -fomit-frame-pointer \
		#  -fverbose-asm \

CC:=gcc

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

DEBUG:=-g

%.o: %.asm
	nasm -f elf32 $(DEBUG) $< -o $@

%.o: %.c
	gcc $(CFLAGS) $(DEBUG) -c $< -o $@

%.c: %.cc
	gcc $(CFLAGS) $(DEBUG) -E $< -o $@

# %.o: %.s
# 	as -32 $< -o $@

%.bin: %.asm
	nasm $(DEBUG) $< -o $@

%.out: %.o
	# ld -m elf_i386 -static $< -o $@ -e main
	gcc $(CFLAGS) $(DEBUG) $< -o $@ 

call.out: call.o subcall.o
	gcc $(CFLAGS) $(DEBUG) $^ -o $@

cstring.out: cstring.o astring.o
	gcc $(CFLAGS) $(DEBUG) $^ -o $@

.PHONY:clean
clean:
	rm -rf *.o
	rm -rf *.out
	rm -rf *.bin
