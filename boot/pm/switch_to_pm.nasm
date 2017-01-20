[bits 16]

; Switch to protected mode
switch_to_pm:
    
    cli                     ; We must switch off interrupts until we have
                            ; set-up the protected mode interrupt vector
                            ; Otherwise interrupts will un riot

    lgdt [gdt_descriptor]   ; Load out GDT, which defines the protected
                            ; mode segments

    mov eax, cr0            ; Set the first bit of CR0 to switch
    or eax, 0x1             ; to protected mode
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; Make a far jump (i.e. to a new segment) to
                            ; our 32-bit code. This also forces the CPU to
                            ; flush its cache of pre-fetched and real-mode
                            ; decoded instructions, which can cause problems

[bits 32]
; Initialize registers and stack once in PM
init_pm:
    
    mov ax, DATA_SEG        ; Now in PM, our old segments are meaningless,
    mov ds, ax              ; so we point our segment registers to the
    mov ss, ax              ; data selector we defined in our GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Update the stack position
    mov esp, ebp

    call BEGIN_PM           ; Finally, call some well-known label

