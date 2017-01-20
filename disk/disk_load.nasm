; load DH sectors from ES:BX from drive DL
disk_load:
    push dx         ; Store DX on stack to recall later

    mov ah, 0x02    ; BIOS read sector function
    mov al, dh      ; Read DH sectors
    mov ch, 0x00    ; Cylinder 0
    mov dh, 0x00    ; Select head 0
    mov cl, 0x02    ; Start reading from second sector
    
    int 0x13        ; BIOS interrupt

    jc disk_error   ; Jump if error (i.e. carry flag set)

    pop dx          ; Restore dx from stack
    cmp dh, al
    jne disk_error  ; Display error message
    ret


disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $


; VARIABLES
DISK_ERROR_MSG: db "Disk read error!", 0

