[org 0x7c00]
; 
; A simple boot sector program that prints a message to screen
; 
mov bp, 0x9000              ; Set the stack safely out of the way
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string

call switch_to_pm

jmp $


%include "print/print_string.nasm"
%include "pm/gdt.nasm"
%include "pm/print_string_pm.nasm"
%include "pm/switch_to_pm.nasm"

[bits 32]
; This is where we arrive after switching to and initialising protected mode
BEGIN_PM:
    
    mov ebx, PROT_MODE_MSG
    call print_string_pm        ; Use our 32-bit print routine

    jmp $                       ; Hang


; Global Variables
REAL_MODE_MSG db "Started in 16-bit Real Mode", 0
PROT_MODE_MSG db "Successfully landed in 32-bit Protected Mode", 0


;
; Padding and magic number
;
times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes
dw 0xaa55

