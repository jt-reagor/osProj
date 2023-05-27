[org 0x7c00]      ; does some offset stuff for us!
                  ; tells assembler to correct label refs
                  ; according to this offset
mov ah, 0x0e      ; prep ax for printing

; mov bx, 0x7c00  ; set bx to boot sector start
                  ; not necessary with 1st line
mov bx, message   ; add the offset to bx

print:
    mov al, [bx]  ; load value held at bx into ax
    int 0x10      ; call print interrupt
    add bx, 0x1   ; move bx pointer up 1 byte 
    cmp byte [bx], 0x0    ; check if bx has reached end of message
    je end
    jmp print

message:
    db 'Booting OS',0

end:
    jmp $         ; jump to current position

times 510-($-$$) db 0
dw 0xaa55