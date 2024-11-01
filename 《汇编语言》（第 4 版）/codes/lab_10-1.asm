assume ds:data, cs:code

data segment
  db 'Welcome to masm!', 0
data ends

code segment
       start: mov dh, 8
              mov dl, 3
              mov cl, 2h
              mov ax, data
              mov ds, ax
              mov si, 0h
              call print

              mov ax, 4c00h
              int 21h

              ; Function:
              ;   Name: print
              ;   Description: Print string which ends with zero
              ;                with given style in special position.
              ;
              ; Arguments:
              ;   DH: Row address. Range: [0 ~ 24]
              ;   DL: Column address. Range: [0 ~ 79]
              ;   CL: Style of the ASCII code.
              ;   DS:SI: Start address of the string.
              ;
              ; Return value: None
       print: push bp
              mov bp, sp

              push dx
              push cx
              push si

              mov ax, 0b800h
              mov es, ax

              ; row address
              mov ax, 0a0h
              mul byte ptr [bp - 1h]
              push ax

              ; column address
              mov al, 2h
              mul byte ptr [bp - 2h]

              pop di
              add di, ax

              mov ch, 0h
  print_char: mov cl, ds:[si]
              jcxz print_ret
              mov es:[di], cl
              mov cl, [bp - 4h]
              mov es:[di + 1h], cl
              inc si
              add di, 2h
              jmp short print_char
   print_ret: pop si
              pop cx
              pop dx
              mov sp, bp
              pop bp
              ret
code ends

end start
