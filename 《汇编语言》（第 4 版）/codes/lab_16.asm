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
      cli
      mov word ptr es:[4 * 7ch], 200h
      mov word ptr es:[4 * 7ch + 2h], 0h
      sti

    ; entry
    mov ah, 0h
    int 7ch

    mov ax, 4c00h
    int 21h

    ;; Function:
    ;;   - Name: int_7c_handler
    ;;   - Description: A simple interrupt handler with 4 sub handlers.
    ;;
    ;; Arguments:
    ;;   - AH: Sub handler number. Range: [0h ~ 3h]
    ;;   - AL: Style code for 0x1 and 0x2 interrupt handler.
    ;;
    ;; Sub handlers:
    ;;   - 0x0: Clear screen.
    ;;   - 0x1: Set foreground color.
    ;;   - 0x2: Set background color.
    ;;   - 0x3: Scroll up a line.
    ;;
    ;; Return value: None
    org 200h
    int_7c_handler:
      push bp
      mov bp, sp

      call get_option

      int_7c_handler_ret:
        mov sp, bp
        pop bp
        iret

      get_option:
        push bp
        mov bp, sp

        push bx

        jmp short perform

        options dw clear, set_fg, set_bg, scroll_up_line

        perform:
          cmp ah, 3h
          ja perform_ret

          mov bl, ah
          mov bh, 0h
          add bx, bx

          call word ptr options[bx]

        perform_ret:
          pop bx

          mov sp, bp
          pop bp
          ret

      ;; Function:
      ;;   - Name: clear
      ;;   - Description: Clear screen.
      ;;
      ;; Arguments: None
      ;;
      ;; Return value: None
      clear:
        push bp
        mov bp, sp

        push ax
        push bx
        push cx
        push dx

        ; https://en.wikipedia.org/wiki/INT_10H
        mov ah, 06h
        mov al, 0h
        mov bh, 7h
        mov cx, 0h
        mov dx, 184fh
        int 10h

        pop dx
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp
        ret

      ;; Function:
      ;;   - Name: set_fg
      ;;   - Description: Set foreground color.
      ;;
      ;; Arguments:
      ;;   - AL: Style code.
      ;;
      ;; Return value: None
      set_fg:
        push bp
        mov bp ,sp

        push bx
        push cx
        push es

        mov bx, 0b800h
        mov es, bx

        mov bx, 1
        mov cx, 2000
        fg:
          and byte ptr es:[bx], 11111000b
          or es:[bx], al
          add bx, 2
          loop fg

        pop es
        pop cx
        pop bx

        mov sp, bp
        pop bp
        ret

      ;; Function:
      ;;   - Name: set_bg
      ;;   - Description: Set background color.
      ;;
      ;; Arguments:
      ;;   - AL: Style code.
      ;;
      ;; Return value: None
      set_bg:
        push bp
        mov bp, sp

        push ax
        push bx
        push cx
        push es

        mov bx, 0b800h
        mov es, bx

        mov cl, 4
        shl al, cl

        mov bx, 1
        mov cx, 2000
        bg:
          and byte ptr es:[bx], 10001111b
          or es:[bx], al
          add bx, 2
          loop bg

        pop es
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp
        ret

      ;; Function:
      ;;   - Name: scroll_up_line
      ;;   - Description: Scroll up a line.
      ;;
      ;; Arguments: None
      ;;
      ;; Return value: None
      scroll_up_line:
        push bp
        mov bp, sp

        push ax
        push bx
        push cx
        push dx

        ; https://en.wikipedia.org/wiki/INT_10H
        mov ah, 06h
        mov al, 1h
        mov bh, 7h
        mov cx, 0h
        mov dx, 184fh
        int 10h

        pop dx
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp
        ret

      int_7c_handler_end:
        nop
code ends

end start
