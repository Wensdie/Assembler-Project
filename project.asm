org 100h

section .text

start:
    mov dx, welcome
    call print
    loop:
        mov dx, text
        call print
        mov ah, 1
	    int 21h
	    cmp al, 176
        je reverse
        cmp al, 13
        je end

print:
    mov ah, 9
    int 21h

reverse:
    jmp loop

end: 
    mov ax, 4c00h
    int 21h

section .data
    welcome db "Program odwracajacy ciag znakow. $"
    text db "Podaj ciag (operacje zatwierdzasz klawiszem '~' - TYLDA): $"