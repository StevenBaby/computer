
CFLAGS:= -m32 \
		 -O0 \
		 -static \
		 -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -fno-pie \
		 -mpreferred-stack-boundary=2 \
		 -fno-stack-protector \
		 -fno-builtin \
		 -fomit-frame-pointer \
		 -nostdlib \
		 -nodefaultlibs \
		 -nostdinc \
		 -nostartfiles \

build/%.bin: src/%.asm
	nasm $< -o $@

build/%.o: src/%.asm
	nasm -f elf32 $< -o $@

build/%.o: src/%.c
	gcc $(CFLAGS) -c $< -o $@

ENTRYPOINT:= 0x00011000

build/kernel.bin: build/start.o build/main.o
	ld -m elf_i386 -static $^ -o $@ -Ttext $(ENTRYPOINT)

build/master.img: build/boot.bin build/loader.bin build/kernel.bin
ifeq ("$(wildcard build/master.img)", "")
	bximage -q -hd=16 -mode=create -sectsize=512 -imgmode=flat $@
endif
	dd if=build/boot.bin of=$@ bs=512 count=1 conv=notrunc
	dd if=build/loader.bin of=$@ bs=512 count=4 seek=2 conv=notrunc
	dd if=build/kernel.bin of=$@ bs=512 count=100 seek=10 conv=notrunc

.PHONY:bochs
bochs: build/master.img
	rm -rf build/bx_enh_dbg.ini
	cd build && bochs -q -unlock

.PHONY:clean
clean:
	rm -rf build/bx_enh_dbg.ini
	rm -rf build/master.img
	rm -rf build/*.bin
