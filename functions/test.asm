[org 0x7c00]

mov bx, MSG
call print_string
mov dx, 0xaf21
call print_hex

jmp $

%include "utils.asm"

MSG:
    db 'Booting OS',10,13,0


times 510-($-$$) db 0
dw 0xaa55