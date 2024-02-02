org 100h

section .text

_start:
    mov dx, welcome
    call print
    
    menu:
        mov dx, text
        call print
        string:
            mov ah, 0
            int 16h
            cmp al, 13
            je stackout
            cmp al, 8
            je backspace
            mov bl, al
            mov bh, 0
            push bx
            mov dx, bx
            mov ah, 2
            int 21h
            add byte [i], 1
            jmp string 
            
        stackout:
            cmp byte [i], 0
            je string
            mov dx, text2
            call print
            mov cx, [i]
            looop:
                pop dx
                mov ah, 02h
                int 21h
            loop looop
            mov ax, 0
            mov [i], ax

        mov dx, text1
        call print
        mov ah, 0
        int 16h
        cmp al, 13
        je end
        jmp menu

    end: 
        mov ax, 4c00h
        int 21h
    
    backspace:
        cmp byte [i], 0
        je string
        mov ah, 02h
        mov dx, 8
        int 21h 
        mov dx, 32
        int 21h 
        mov dx, 8
        int 21h
        pop ax
        mov ax, 0
        sub byte [i], 1
        jmp string

    print:
        mov ah, 9
        int 21h
        xor dx, dx
        ret
        
section .data
    welcome db "Program odwracajacy ciag znakow.", 13, 10, "$"
    text db 13, 10, "Podaj ciag:", 13, 10, "$"
    text1 db 13, 10, 13, 10, "Kliknij dowolny przycisk, aby kontynuowac, kliknij ENTER aby zakonczyc dzialanie programu.", 13, 10, "$"
    text2 db 13, 10, 13, 10, "Wynik: ", 13, 10, "$"
    i dw 0