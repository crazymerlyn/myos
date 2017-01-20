[org 0x7c00]
; 
; A simple boot sector program that prints a message to screen
; 
mov [BOOT_DRIVE], dl       ; BIOS stores our drive in DL
                            ; It's best to remember this for later


mov bp, 0x8000              ; Set the stack safely out of the way
mov sp, bp


mov bx, 0x9000              ; Load 5 sectors at 0x0000(ES):0x9000(BX)
mov dh, 2                   ; from the disk
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $


%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"


; Global Variables
BOOT_DRIVE: db 0

;
; Padding and magic number
;

times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes
dw 0xaa55


times 256 dw 0xdada
times 256 dw 0xface

