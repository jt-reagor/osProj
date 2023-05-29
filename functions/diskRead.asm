[org 0x7c00]

mov [BOOT_DRIVE], dl    ; remember where out boot_drive is

mov bp, 0x8000          ; put our stack somewhere safe (grows downward)
mov sp, bp

mov bx, 0x9000
mov dh, 5               ; write 5 sectors
mov dl, [BOOT_DRIVE]    ; write from boot_drive 0 (defined below)
call disk_load          ; writes to ES:BX, 0x9000


mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $


BOOT_DRIVE: db 0

%include "./utils.asm"


times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdead
times 256 dw 0xbeef