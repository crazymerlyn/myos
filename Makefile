BOOTLOAD_SOURCES := $(shell find . -iname "*.nasm")
KERNEL_SOURCES := kernel.c

all: boot_sect.bin


boot_sect.bin: $(BOOTLOAD_SOURCES)
	nasm boot_sect.nasm -f bin -o boot_sect.bin

kernel.bin: $(KERNEL_SOURCES)
	gcc -m32 -ffreestanding -c kernel.c -o kernel.o
	ld -melf_i386 -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

os.bin: boot_sect.bin kernel.bin
	cat boot_sect.bin kernel.bin > os.bin

run: os.bin
	qemu-system-i386 os.bin


clean:
	@rm -rf *.bin *.o

.PHONY: all run clean

