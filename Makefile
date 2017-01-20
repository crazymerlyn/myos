SOURCES := $(wildcard *.nasm)

all: boot_sect.bin


boot_sect.bin: $(SOURCES)
	nasm boot_sect.nasm -f bin -o boot_sect.bin



run: boot_sect.bin
	qemu-system-i386 boot_sect.bin


clean:
	@rm -rf *.bin

.PHONY: all run clean

