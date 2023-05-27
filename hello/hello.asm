
mov ah, 0x0e  ; The high order byte of ax set to 0x0e to indicate tele-type mode in BIOS

mov al, 'H'   ; Set low order byte to print
int 0x10      ; Call interrupt service routine
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

;jmp $$        ; jump to beginning of boot (prints Hello forever)
jmp $         ; jump to current position

times 510-($-$$) db 0
dw 0xaa55