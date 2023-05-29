; simple print function that prints until null terminator
; bx: address of string
print_string:
    pusha                     ; push regs onto stack for safe-keeping
    mov ah, 0x0e              ; prep ax
    print_string_loop:
        cmp byte [bx], 0x0    ; compare pointer data with null terminator
        je print_string_end                ; if null term, go to end
        mov al, [bx]          ; else, load al with data from
        int 0x10              ; call bios interrupt to print
        add bx, 0x1           ; increment pointer
        jmp print_string_loop
    print_string_end:
        popa                  ; return regs to normal state
        ret


; simple print function that prints hex values
; dx: hex value
print_hex:
    pusha
    mov cx, 12                  ; used to track how far to shift ax
    mov bx, HEX_TEMPLATE        ; pointer to HEX_TEMPLATE
    add bx, 0x2                 ; shift up to first digit
    mov ax, 0xf000              ; mask
    print_hex_loop:
        and ax, dx              ; and mask with input in dx
        shr ax, cl              ; shift mask right
        call to_ascii           ; convert masked value to ascii
        mov [bx], al            ; place ascii value in template
        add bx, 0x1             ; shift template pointer over 1 byte
        sub cx, 4               ; decrease shift amount by 4 bits
        cmp cx, 0               ; check to see if job is done
        jl print_hex_end        ; if so, end
        mov ax, 0xf             ; if not, reset mask
        shl ax, cl              ; and shift mask back into position
        jmp print_hex_loop
    print_hex_end:
        mov bx, HEX_TEMPLATE    ; prep output for printing
        call print_string
        popa
        ret
    HEX_TEMPLATE:               ; template to be edited by print_hex_loop
        db '0x!!!!',13,10,0

to_ascii:
    add ax, 48
    cmp ax, 0x3A
    jl to_ascii_skip
    add ax, 7
    to_ascii_skip:
    ret

; load DH sectors to ES:BX from drive DL
; parameters: DL = drive number, DH = number of sectors to read, ES:BX = where to write
;
; BIOS regs expectation for int 0x13:
; dl: drive number, dh: head number (0-x)
; cl: sector number (1-x), ch: cylinder number (1-x)
; al: how many sectors to read
; ES:BX: where to write sectors
disk_load:
    pusha
    push dx         ; push dx onto stack to be used later.
    mov ah, 0x02    ; bios read sector function
    mov al, dh      ; Read dh sectors
    mov ch, 0x00    ; select cylinder 0
    mov dh, 0x00    ; select head 0
    mov cl, 0x02    ; read from second sector (sector after boot)
    int 0x13        ; BIOS interrupt to read
                    ; Note, this writes to ES:BX
    
    jc disk_load_error ; Jump if error (check carry flag)

    pop dx
    cmp dh, al
    jne disk_load_error
    popa
    ret
    
    disk_load_error:
        mov bx, DISK_LOAD_ERROR_MSG
        call print_string
        pop dx
        popa
        ret
    DISK_LOAD_ERROR_MSG:
        db "Disk read error!",13, 10, 0

