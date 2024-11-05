assume cs:code

data segment
  db 'conversation', 0
data ends

code segment
  start:
    ;; Function:
    ;;   - Name: install_int_0_handler
    ;;   - Description: Install int_0_handler to 0000:0200
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
      mov word ptr es:[4 * 7ch], 200h
      mov word ptr es:[4 * 7ch + 2h], 0h

    ;; entry
    mov ax, data
    mov ds, ax
    mov si, 0h

    mov ax, 0b800h
    mov es, ax
    mov di, 780h

    s:
      cmp byte ptr [si], 0h
      je ok
      mov al, [si]
      mov es:[di], al
      inc si
      add di, 2h
      mov bx, offset s - offset ok
      int 7ch

    ok:
      mov ax, 4c00h
      int 21h

    ;; Function:
    ;;   - Name: int_7c_handler
    ;;   - Description: Imitate `jmp near ptr label` instruction's function.
    ;;
    ;; Arguments:
    ;;   - BX: Jump offset.
    ;;
    ;; Return value: None
    int_7c_handler:
      push bp
      mov bp, sp

      add [bp + 2h], bx

      mov sp, bp
      pop bp
      iret

      int_7c_handler_end:
        nop
code ends

end start
