assume cs:code

code segment
  start:
    ;; Function:
    ;;   - Name: install_int_0_handler
    ;;   - Description: Install int_0_handler to 0000:0200
    ;;
    ;; Arguments: None
    ;;
    ;; Return value: None
    install_int_0_handler:
      mov ax, cs
      mov ds, ax
      mov si, offset int_0_handler

      mov ax, 0h
      mov es, ax
      mov di, 200h

      mov cx, offset int_0_handler_end - offset int_0_handler
      cld
      rep movsb

      ; Set interrupt vector table
      mov ax, 0h
      mov es, ax
      mov word ptr es:[4 * 0], 200h
      mov word ptr es:[4 * 0 + 2], 0h

      mov ax, 4c00h
      int 21h

    ;; Function:
    ;;   - Name: int_0_handler
    ;;   - Description: Handle divide overflow error.
    ;;
    ;; Arguments: None
    ;;
    ;; Return value: None
    int_0_handler:
      jmp short int_0_handler_main
      db "Divide error!", 0

      int_0_handler_main:
        mov ax, cs
        mov ds, ax
        mov si, 202h

        mov ax, 0b800h
        mov es, ax
        mov di, 0h

        mov ch, 0h
      throw_error:
        mov cl, [si]
        jcxz int_0_handler_ret
        mov es:[di], cl
        mov byte ptr es:[di + 1], 7h
        inc si
        add di, 2h
        loop throw_error

      int_0_handler_ret:
        mov ax, 4c00h
        int 21h

      int_0_handler_end:
        nop
code ends

end start
