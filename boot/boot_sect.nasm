[org 0x7c00]
; A boot sector that boots a C kernel in 32-bit protected mode

KERNEL_OFFSET equ 0x1000    ; This is the memory offset where the kernel will
                            ; be loaded

mov [BOOT_DRIVE], dl        ; BIOS stores the boot drive in DL
                            ; So, it's best to remember this for later

mov bp, 0x9000              ; Set the stack safely out of the way
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string

call load_kernel            ; Load the kernel

call switch_to_pm

jmp $


%include "print/print_string.nasm"
%include "disk/disk_load.nasm"
%include "pm/gdt.nasm"
%include "pm/print_string_pm.nasm"
%include "pm/switch_to_pm.nasm"

[bits 16]
; Load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL     ; Print a message saying that kernel is loading
    call print_string

    mov bx, KERNEL_OFFSET       ; Set-up parameters for our disk_load routine
    mov dh, 1                   ; so that the first 15 sectors (excluding
    mov dl, [BOOT_DRIVE]        ; the boot sector) are loaded from the boot
    call disk_load              ; disk to the address KERNEL_OFFSET

    ret

[bits 32]
; This is where we arrive after switching to and initialising protected mode
BEGIN_PM:
    
    mov ebx, PROT_MODE_MSG
    call print_string_pm        ; Use our 32-bit print routine
    
    call KERNEL_OFFSET          ; Now, jump to the address of the
                                ; loaded kernel code

    jmp $                       ; Hang


; Global Variables
BOOT_DRIVE db 0
REAL_MODE_MSG db "Started in 16-bit Real Mode", 0
PROT_MODE_MSG db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

;
; Padding and magic number
;
times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes
dw 0xaa55

