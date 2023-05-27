mov bx, 30

a:
    cmp bx, 4
    jg b
    mov al, 'A'
    jmp done
b:
    cmp bx, 40
    jge c
    mov al, 'B'
    jmp done
c:
    mov al, 'C'

done:
    mov ah, 0x0e
    int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55