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
    ;
    ; CAUTION: We should temporary shielding external interrupt to avoid
    ;          perform wrong interrupt handler.
    ;
    ; e.g. If we get an external keyboard interrupt after the first mov
    ;      instruction performed, int 9 handler will be loaded in wrong
    ;      address. Cause the int 9 handler's offset address is not
    ;      set yet.
    cli
    mov word ptr es:[4h * 9h], offset int_9_handler
    mov es:[4h * 9h + 2h], cs
    sti

    ;; Function:
    ;;   - Name: print_char
    ;;   - Description: One by one print out a ~ z to B800:0000
    ;;
    ;; Arguments: None
    ;;
    ;; Return value: None
    mov ax, 0b800h
    mov es, ax

    mov al, 'a'
    print_char:
      mov es:[0 * 160 + 0 * 40], al
      call delay
      inc al
      cmp al, 'z'
      jna print_char

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

      mov dx, 0f000h
      mov ax, 0h

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
      push es

      ; get pressed key's info
      in al, 60h

      ; call the origional int 9 interrupt handler to handle hardware details
      pushf
      call dword ptr ds:[0]

      ; if pressed <ESC>, change color
      cmp al, 1
      jne int_9_handler_ret

      mov ax, 0b800h
      mov es, ax

      inc byte ptr es:[0 * 160 + 0 * 40 + 1]

      int_9_handler_ret:
        pop es
        pop bx
        pop ax

        mov sp, bp
        pop bp
        iret
code ends

end start
