; GDT
gdt_start:

gdt_null:   ; The mandatory null descriptor
    dd 0x0  ; dd means define double word (i.e. 4 bytes)
    dd 0x0

gdt_code:   ; The code segment descriptor
    ; base = 0x0, limit = 0xfffff,
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit)0 (AVL)0 -> 1100b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; 1st flags, type flags
    db 11001111b    ; 2nd flags, Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_data:   ; The data segment descriptor
    ; Same as code segment except for the type flags
    ; type flags: (code)0 (conforming)0 (readable)1 (accessed)0 -> 1010b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10010010b    ; 1st flags, type flags
    db 11001111b    ; 2nd flags, Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_end:            ; The reason for putting a label at the end of GDT
                    ; is so we can have the assembler calculate the size
                    ; of the GDT for the GDT descriptor


; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT - 1
    dd gdt_start                ; Start address of our GDT


; Define some handy constants for GDT segment descriptor offsets, which
; are what the segment registers must contain when in protected mode.
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

