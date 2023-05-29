; [org 0x7c00]
mov bx, 0x7c0  ; segment registers must take another register's val, not an immediate
mov ds, bx

mov bx, MSG
call print_string
mov dx, 0x1234
call print_hex

jmp $

%include "utils.asm"

MSG:
    db 'Booting OS',10,13,0
MSG2:



times 510-($-$$) db 0
dw 0xaa55