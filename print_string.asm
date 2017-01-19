print_string:
    pusha
    mov ah, 0x0e
    loop_start:
    cmp byte [bx], 0
    je loop_end
    mov al, [bx]
    int 0x10
    add bx, 1
    jmp loop_start
    loop_end:
    popa
    ret

