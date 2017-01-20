BOOTLOAD_SOURCES := $(shell find . -iname "*.nasm")
C_SOURCES := $(wildcard kernel/*.c drivers/*.c)
HEADERS := $(wildcard kernel/*.h drivers/*.h)
OBJ := $(C_SOURCES:.c=.o)

# Default build target
all: os.bin


boot/boot_sect.bin: $(BOOTLOAD_SOURCES)
	nasm boot/boot_sect.nasm -f bin -I 'boot/' -o boot/boot_sect.bin

kernel.bin: kernel/kernel_entry.o $(OBJ)
	ld -melf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

os.bin: boot/boot_sect.bin kernel.bin
	cat $^ > os.bin

run: all
	qemu-system-i386 os.bin

%.o : %.c $(HEADERS)
	i686-elf-gcc -ffreestanding -c $< -o $@

%.o : %.nasm
	nasm $< -f elf -o $@

%.bin : %.nasm
	nasm $< -f bin -o $@

clean:
	@rm -rf *.bin *.o */*.bin */*.o

.PHONY: all run clean

