assume cs:code

data segment
  db "welcome to masm! ", 0
data ends

code segment
  start:
    ;; Function:
    ;;   - Name: install_int_7c_handler
    ;;   - Description: Install int_7c_handler to 0000:0200
    ;;
    ;; Arguments: None
    ;;
    ;; Return value: None
    install_int_7c_handler:
      mov ax, cs
      mov ds, ax
      mov si, offset int_7c_handler

      mov ax, 0h
      mov es, ax
      mov di, 200h

      mov cx, offset int_7c_handler_end - offset int_7c_handler
      cld
      rep movsb

      mov ax, 0h
      mov es, ax
      mov di, 7ch

      ; set interrupt vector table
      mov word ptr es:[4 * 7ch], 200h
      mov word ptr es:[4 * 7ch + 2h], 0h

    ; entry
    mov dh, 10
    mov dl, 10
    mov cl, 2h
    mov ax, data
    mov ds, ax
    mov si, 0
    int 7ch

    mov ax, 4c00h
    int 21h

    ;; Function:
    ;;   - Name: int_7c_handler
    ;;   - Description: Print out given string to special line.
    ;;
    ;; Arguments:
    ;;   - DH: Row address. Range: [0 ~ 24]
    ;;   - DL: Column address. Range: [0 ~ 79]
    ;;   - CL: Style of the ASCII code.
    ;;   - DS:SI: Start address of the string.
    ;;
    ;; Return value: None
    int_7c_handler:
      push bp
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
      print_char:
        mov cl, ds:[si]
        jcxz int_7c_handler_ret
        mov es:[di], cl
        mov cl, [bp - 4h]
        mov es:[di + 1h], cl
        inc si
        add di, 2h
        jmp short print_char

      int_7c_handler_ret:
        pop si
        pop cx
        pop dx
        mov sp, bp
        pop bp
        iret

      int_7c_handler_end:
        nop
code ends

end start
