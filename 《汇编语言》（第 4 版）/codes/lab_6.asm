assume cs:code, ss:stack, ds:data

stack segment
  dw 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
stack ends

data segment
  db '1. display      '
  db '2. brows        '
  db '3. replace      '
  db '4. modify       '
data ends

code segment
  start:  mov ax, data
          mov ds, ax

          mov ax, stack
          mov ss, ax
          mov sp, 10h

          mov bx, 0h

          mov cx, 4h
  row:    push cx
          mov cx, 4h
          mov si, 0h

  column: mov al, [bx + 3h + si]
          and al, 11011111b
          mov [bx + 3h + si], al
          inc si
          loop column
          add bx, 10h
          pop cx
          loop row

          mov ax, 4c00h
          int 21h
code ends

end start
