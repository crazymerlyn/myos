[org 0x7c00]
; 
; A simple boot sector program that prints a message to screen
; 

mov dx, 0x1f46
call print_hex

jmp $


print_hex:
    pusha
    mov cx, 3

    hex_loop_start:
    cmp cx, 0
    jl hex_loop_end
    mov ax, dx

    shr ax, cl
    shr ax, cl
    shr ax, cl
    shr ax, cl
    and ax, 0xf
    
    cmp ax, 9
    jg hexadecimal
    add ax, '0'
    jmp hex_cond_end
    hexadecimal:
    add ax, 'a'-10
    hex_cond_end:
    mov bx, 5
    sub bx, cx
    mov [HEX_OUT+bx], ax
    
    sub cx, 1
    jmp hex_loop_start

    hex_loop_end:

    mov bx, HEX_OUT
    call print_string
    popa
    ret


%include "print_string.asm"

HEX_OUT:
    db "0x0000", 0

;
; Padding and magic number
;

times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes

dw 0xaa55

