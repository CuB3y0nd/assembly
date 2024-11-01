assume ds:data, cs:code

data segment
  dw 123, 12666, 1, 8, 3, 38
data ends

string segment
  db 0ah dup (0h)
string ends

code segment
         start: mov ax, data
                mov es, ax

                mov si, 4h
                mov ax, es:[si]
                mov bx, string
                mov ds, bx
                call dtoc

                mov si, 0h
                mov dh, 8
                mov dl, 3
                mov cl, 2h
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
                jcxz print_return
                mov es:[di], cl
                mov cl, [bp - 4h]
                mov es:[di + 1h], cl
                inc si
                add di, 2h
                jmp short print_char
  print_return: mov sp, bp
                pop bp
                ret

                ; Function:
                ;   Name: dtoc
                ;   Description: Convert WORD type data to
                ;                decimal string ends with zero.
                ;
                ; Arguments:
                ;   AX: WORD type data
                ;   DS:SI: Start address of the string.
                ;
                ; Return value: None
          dtoc: push bp
                mov bp, sp

                push si

     to_string: mov cx, 0ah
                mov dx, 0h
                div cx
                add dx, 30h
                push dx
                inc si
                mov cx, ax
                jcxz dtoc_return
                jmp to_string
   dtoc_return:
                sub si, [bp - 2h]
                mov byte ptr [si], 0h
                mov cx, si
                mov si, 0h
      generate: pop [si]
                inc si
                loop generate

                pop si
                mov sp, bp
                pop bp
                ret
code ends

end start
