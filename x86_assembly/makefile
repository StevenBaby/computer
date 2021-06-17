
build/%.bin: src/%.asm
	nasm $< -o $@

build/master.img: build/boot.bin
ifeq ("$(wildcard build/master.img)", "")
	bximage -q -hd=16 -mode=create -sectsize=512 -imgmode=flat $@
endif
	dd if=$< of=$@ bs=512 count=1 conv=notrunc

.PHONY:bochs
bochs: build/master.img
	rm -rf build/bx_enh_dbg.ini
	cd build && bochs -q -unlock

.PHONY:clean
clean:
	rm -rf build/bx_enh_dbg.ini
	rm -rf build/master.img
	rm -rf build/*.bin
