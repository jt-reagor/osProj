mov ah, 0x0e       ; int 10/ ah = 0eh -> scrolling teletype BIOS routine


mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx             ; pop and push only work in words, not bytes
mov al, bl         ; move low byte of popped word into al
int 0x10

mov al, [0x7ffe]   ; check what is at the bottom of the stack
int 0x10

end:
    jmp $

times 510-($-$$) db 0
dw 0xaa55