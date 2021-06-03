
%.bin: %.asm
	nasm $< -o $@

master.img: boot.bin
ifeq ("$(wildcard master.img)", "")
	bximage -q -hd=16 -mode=create -sectsize=512 -imgmode=flat $@
endif
	dd if=$< of=$@ bs=512 count=1 conv=notrunc

.PHONY:bochs
bochs: master.img
	rm -rf bx_enh_dbg.ini
	bochs -q -unlock

.PHONY:clean
clean:
	rm -rf master.img
	rm -rf *.bin
