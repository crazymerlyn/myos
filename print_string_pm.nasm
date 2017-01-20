[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
GREEN_ON_BLACK equ 0x02

; Prints a null terminated string pointed to by EBX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY
        
print_string_pm_loop:
    mov al, [ebx]			; Store the character in AL
    mov ah, GREEN_ON_BLACK 	; Store the attributes in AH

	cmp al, 0				; Check if character is null
	je print_string_pm_done

	mov [edx], ax			; Store characters and attributes at current

	add ebx, 1				; Increment EBX to next char in string
	add edx, 2				; Move to the next cell in Video Memory

	jmp print_string_pm_loop ; Jump to start to print the next character

print_string_pm_done:
    popa
    ret

