assume ds:data, cs:code

data segment
  db 'welcome to masm!'
data ends

code segment
  start:
    mov ax, data
    mov ds, ax

    mov ax, 0b800h
    mov es, ax

    mov bx, 06e0h
    mov si, 0h
    mov di, 04eh
    mov cx, 10h
  line_1:
    mov al, [si]
    mov ah, 02h
    push ax
    pop es:[bx + di]
    inc si
    add di, 2h
    loop line_1

    mov si, 0h
    mov di, 04eh
    mov cx, 10h
  line_2:
    mov al, [si]
    mov ah, 24h
    push ax
    pop es:[bx + di]
    inc si
    add di, 2h
    loop line_2

    mov si, 0h
    mov di, 04eh
    mov cx, 10h
  line_3:
    mov al, [si]
    mov ah, 71h
    push ax
    pop es:[bx + di]
    inc si
    add di, 2h
    loop line_3

    mov ax, 4c00h
    int 21h
code ends

end start
