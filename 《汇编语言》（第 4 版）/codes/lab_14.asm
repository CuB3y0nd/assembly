assume cs:code

code segment
  start:
    call time

    mov ax, 4c00h
    int 21h

  ;; Function:
  ;;   - Name: time
  ;;   - Description: Print out current time from CMOS RAM.
  ;;
  ;; Time format: yy/mm/dd hr:mi:se
  ;;
  ;; Arguments: None
  ;;
  ;; Return value: None
  time:
    push bp
    mov bp, sp

    mov ax, 0h
    mov al, 0h
    out 70h, al
    in al, 71h
    push ax

    mov al, 2h
    out 70h, al
    in al, 71h
    push ax

    mov al, 4h
    out 70h, al
    in al, 71h
    push ax

    mov al, 7h
    out 70h, al
    in al, 71h
    push ax

    mov al, 8h
    out 70h, al
    in al, 71h
    push ax

    mov al, 9h
    out 70h, al
    in al, 71h
    push ax

    mov ax, 0b800h
    mov es, ax

    ; this part handle yy/mm/dd
    mov bx, sp
    mov si, 0h
    mov di, 0h
    mov cx, 3h
    _date:
      push cx
      mov ah, ss:[bx + si]
      mov cl, 4h
      shr ah, cl
      mov al, ss:[bx + si]
      and al, 00001111b
      add ah, 30h
      add al, 30h

      mov es:[di], ah
      mov byte ptr es:[di + 1h], 7h
      add di, 2h
      mov es:[di], al
      mov byte ptr es:[di + 1h], 7h
      add di, 2h
      pop cx
      cmp cx, 1
      je _date_ret
      mov byte ptr es:[di], 2fh
      mov byte ptr es:[di + 1h], 7h
      add si, 2h
      add di, 2h
      loop _date

      _date_ret:
        mov byte ptr es:[di], 20h
        mov byte ptr es:[di + 1h], 7h
        add di, 2h

    ; this part handle hr/mi/se
    mov si, 6h
    mov cx, 3h
    _time:
      push cx
      mov ah, ss:[bx + si]
      mov cl, 4h
      shr ah, cl
      mov al, ss:[bx + si]
      and al, 00001111b
      add ah, 30h
      add al, 30h

      mov es:[di], ah
      mov byte ptr es:[di + 1h], 7h
      add di, 2h
      mov es:[di], al
      mov byte ptr es:[di + 1h], 7h
      add di, 2h
      pop cx
      cmp cx, 1
      je _time_ret
      mov byte ptr es:[di], 3ah
      mov byte ptr es:[di + 1h], 7h
      add si, 2h
      add di, 2h
      loop _time

      _time_ret:
        mov sp, bp
        pop bp
        ret
code ends

end start
