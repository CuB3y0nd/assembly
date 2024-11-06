assume cs:code

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
    mov ax, 0b800h
    mov es, ax
    mov di, 160*12
    mov bx, offset s - offset se
    mov cx, 80
  s:
    mov byte ptr es:[di], '!'
    add di, 2
    int 7ch
  se:
    nop

    mov ax, 4c00h
    int 21h

    ;; Function:
    ;;   - Name: int_7c_handler
    ;;   - Description: Imitate loop instruction's function.
    ;;
    ;; Arguments:
    ;;   - BX: Jump offset.
    ;;   - CX: Loop times.
    ;;
    ;; Return value: None
    int_7c_handler:
      push bp
      mov bp, sp

      jcxz int_7c_handler_ret
      add [bp + 2h], bx

      int_7c_handler_ret:
        dec cx
        mov sp, bp
        pop bp
        iret

      int_7c_handler_end:
        nop
code ends

end start
