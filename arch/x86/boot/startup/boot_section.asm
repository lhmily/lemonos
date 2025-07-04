[org 0x7c00] ; load the program to the boot magic address
mov ax, cs ; set the code section to the register ax
mov ds, ax ; set the data section = ax
mov si, hello_msg ; make the si point to the string
call print_string ;
jmp $ ; infinite loop, preventing the program from continuing
print_string:
    lodsb ; load the first byte of si to al and incr one
    or al, al ; check the al is 0 or not
    jz done ; jump to done when al equals 0
    mov ah, 0x0e ; set the bios interrupt 10h
    mov bh, 0x00 ; display the page number
    mov bl, 0x07 ; white characters and black background
    int 0x10 ; call the bios interrupt 10h to print a letter
    jmp print_string ; next letter
done:
    ret ; return
; the data section
hello_msg: db 'Hello', 0
; padding 0 to 510 bytes
times 510-($-$$) db 0
; add the boot sector signature magic number
dw 0xaa55