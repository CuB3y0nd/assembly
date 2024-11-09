assume cs:code

origional_int_9 segment
  dw 0h, 0h
origional_int_9 ends

code segment
  start:
    ; save origional int 9 interrupt handler address
    mov ax, origional_int_9
    mov ds, ax

    mov ax, 0h
    mov es, ax

    push es:[4h * 9h]
    pop ds:[0]
    push es:[4h * 9h + 2h]
    pop ds:[2]

    ; replace the default int 9 interrupt handler to our custom handler
    cli
    mov word ptr es:[4h * 9h], offset int_9_handler
    mov es:[4h * 9h + 2h], cs
    sti

    ; give a spare interval to detect user input
    call delay

    ; restore the default int 9 handler
    mov ax, 0h
    mov es, ax

    push ds:[0]
    pop es:[4h * 9h]
    push ds:[2]
    pop es:[4h * 9h + 2h]

    mov ax, 4c00h
    int 21h

    ;; Function:
    ;;   - Name: delay
    ;;   - Description: A inferior delay implemention.
    ;;
    ;; Arguments: None
    ;;
    ;; Return value: None
    delay:
      push bp
      mov bp, sp

      push ax
      push dx

      mov dx, 0ffffh
      mov ax, 0ffffh

      dec_times:
        sub ax, 1h
        sbb dx, 0h

        cmp ax, 0h
        jne dec_times
        cmp dx, 0h
        jne dec_times

      pop dx
      pop ax

      mov sp, bp
      pop bp
      ret

    int_9_handler:
      push bp
      mov bp, sp

      push ax
      push bx
      push cx
      push es
      push di

      ; get pressed key's info
      in al, 60h

      ; call the origional int 9 interrupt handler to handle hardware details
      pushf
      call dword ptr ds:[0]

      ; detect if A key is released
      cmp al, 9eh
      jne int_9_handler_ret

      ;; Function:
      ;;   - Name: put_a
      ;;   - Description: Print out A to full screen
      ;;
      ;; Arguments: None
      ;;
      ;; Return value: None
      mov ax, 0b800h
      mov es, ax

      mov al, 'A'
      mov di, 0h
      mov cx, 2000
      print_char:
        mov es:[di], al
        add di, 2h
        loop print_char

      int_9_handler_ret:
        pop di
        pop es
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp
        iret
code ends

end start
