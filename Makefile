

all: boot_sect.bin


boot_sect.bin: boot_sect.asm print_hex.asm print_string.asm disk_load.asm
	nasm boot_sect.asm -f bin -o boot_sect.bin



run: boot_sect.bin
	qemu-system-i386 boot_sect.bin


clean:
	@rm -rf *.bin

.PHONY: all run clean

