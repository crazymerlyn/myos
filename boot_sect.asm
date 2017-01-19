[org 0x7c00]
; 
; A simple boot sector program that prints a message to screen
; 

mov dx, 0x1f46
call print_hex

jmp $


%include "print_string.asm"
%include "print_hex.asm"

;
; Padding and magic number
;

times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes

dw 0xaa55

