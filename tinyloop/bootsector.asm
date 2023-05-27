; COMMENT

loop:
    jmp loop

times 510-($-$$) db 0 ; pads zeros up to 510 bytes
dw 0xaa55             ; boot signature