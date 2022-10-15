mbr.bin:mbr.asm
	nasm mbr.asm -o mbr.bin
	dd if=mbr.bin of=mbr.img bs=512 count=1 conv=notrunc
clean:
	rm mbr.bin