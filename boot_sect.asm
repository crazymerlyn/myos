[org 0x7c00]
; 
; A simple boot sector program that prints a message to screen
; 

mov ah, 0x0e    ; Scrolling teletype routine

mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe]
int 0x10

jmp $ ; Jump to the current address, i.e., forever


;
; Padding and magic number
;

times 510 - ($ - $$) db 0 ; Pad zeroes til 510 bytes

dw 0xaa55

