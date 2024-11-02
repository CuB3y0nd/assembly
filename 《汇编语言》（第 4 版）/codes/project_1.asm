assume cs:code

data segment
  db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
  db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
  db '1993', '1994', '1995'

  dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
  dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

  dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
  dw 11542, 14430, 15257, 17800
data ends

table segment
  db 21 dup ('year summ ne ?? ')
table ends

screen segment
  dd 84 dup (0h)
screen ends

code segment
  start:
    call clear

    mov ax, data
    mov ds, ax

    mov ax, table
    mov es, ax

    mov bx, 0h

    mov ax, 0h
    push ax
    mov ax, 54h
    push ax
    mov ax, 0a8h
    push ax

    mov cx, 15h
    call create_table

  mov ax, table
  mov ds, ax

  mov ax, screen
  mov es, ax

  mov si, 0h
  mov bx, 0h
  mov cx, 15h
  set_year:
    push [bx + si]
    pop es:[bx + si]
    push [bx + si + 2h]
    pop es:[bx + si + 2h]
    add bx, 10h
    loop set_year

  mov dh, 0
  mov dl, 0
  mov si, 0h
  mov cx, 15h
  print_year:
    push cx
    mov cl, 7h
    call print
    inc dh
    add si, 10h
    pop cx
    loop print_year

  mov si, 5h
  mov bx, 0h
  mov cx, 15h
  set_income:
    mov ax, table
    mov ds, ax

    push [bx + si]
    pop ax
    push [bx + si + 2h]
    pop dx

    mov di, screen
    mov ds, di

    push cx
    mov cx, dx
    jcxz use_wtoc
    jmp use_dtoc

    use_wtoc:
      pop cx
      call wtoc
      jmp set_income_outter

    use_dtoc:
      pop cx
      call dtoc

    set_income_outter:
      add bx, 10h
      loop set_income

  mov ax, screen
  mov ds, ax

  mov dh, 0
  mov dl, 7
  mov si, 5h
  mov cx, 15h
  print_income:
    push cx
    mov cl, 7h
    call print
    inc dh
    add si, 10h
    pop cx
    loop print_income

  mov si, 0ah
  mov bx, 0h
  mov cx, 15h
  set_employees:
    mov ax, table
    mov ds, ax

    push [bx + si]
    pop ax

    mov di, screen
    mov ds, di

    call wtoc
    jmp set_employees_outter

    set_employees_outter:
      add bx, 10h
      loop set_employees

  mov ax, screen
  mov ds, ax

  mov dh, 0
  mov dl, 17
  mov si, 0ah
  mov cx, 15h
  print_employees:
    push cx
    mov cl, 7h
    call print
    inc dh
    add si, 10h
    pop cx
    loop print_employees

  mov si, 0dh
  mov bx, 0h
  mov cx, 15h
  set_avg_inc:
    mov ax, table
    mov ds, ax

    push [bx + si]
    pop ax

    mov di, screen
    mov ds, di

    call wtoc
    jmp set_avg_income_outter

    set_avg_income_outter:
      add bx, 10h
      loop set_avg_inc

  mov ax, screen
  mov ds, ax

  mov dh, 0
  mov dl, 25
  mov si, 0dh
  mov cx, 15h
  print_avg_inc:
    push cx
    mov cl, 7h
    call print
    inc dh
    add si, 10h
    pop cx
    loop print_avg_inc

    mov ax, 4c00h
    int 21h

  ;; Function:
  ;;   - Name: create_table
  ;;   - Description: Create the table that the book provided.
  ;;
  ;; Arguments: None
  ;;
  ;; Return value: None
  create_table:
    push bp
    mov bp, sp

    generate:
      year:
        mov si, [bp + 8h]
        push ds:[si]
        pop es:[bx]
        push ds:[si + 2h]
        pop es:[bx + 2h]
        mov byte ptr es:[bx + 4h], 0h

      income:
        mov si, [bp + 6h]
        mov ax, ds:[si]
        mov dx, ds:[si + 2h]
        mov es:[bx + 5h], ax
        mov es:[bx + 7h], dx
        mov byte ptr es:[bx + 9h], 0h

      employees:
        mov si, [bp + 4h]
        push ds:[si]
        pop es:[bx + 0ah]
        mov byte ptr es:[bx + 0ch], 0h

      avg_income:
        div word ptr ds:[si]
        mov es:[bx + 0dh], ax
        mov byte ptr es:[bx + 0fh], 0h

        add word ptr [bp + 8h], 4h
        add word ptr [bp + 6h], 4h
        add word ptr [bp + 4h], 2h
        add bx, 10h

        loop generate

        mov sp, bp
        pop bp
        ret

  ;; Function:
  ;;   - Name: print
  ;;   - Description: Print string which ends with zero
  ;;                  with given style in special position.
  ;;
  ;; Arguments:
  ;;   - DH: Row address. Range: [0 ~ 24]
  ;;   - DL: Column address. Range: [0 ~ 79]
  ;;   - CL: Style of the ASCII code.
  ;;   - DS:SI: Start address of the string.
  ;;
  ;; Return value: None
  print:
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
      jcxz print_ret
      mov es:[di], cl
      mov cl, [bp - 4h]
      mov es:[di + 1h], cl
      inc si
      add di, 2h
      jmp short print_char
    print_ret:
      pop si
      pop cx
      pop dx
      mov sp, bp
      pop bp
      ret

  ;; Function:
  ;;   - Name: divdw
  ;;   - Description: Divide operation without overflow.
  ;;
  ;; General formula:
  ;;   - X/N = int(H/N) * 0x10000 + [rem(H/N) * 0x10000 + L]/N
  ;;
  ;; Placeholder description:
  ;;   - X: Dividend. Range: [0x0 ~ 0xffffffff]
  ;;   - N: Divisor. Range: [0x0 ~ 0xffff]
  ;;   - H: X (Dividend) 's high 16bits. Range: [0x0 ~ 0xffff]
  ;;   - L: X (Dividend) 's low 16bits. Range: [0x0 ~ 0xffff]
  ;;
  ;; Arguments:
  ;;   - DX: Dividend (DWORD) 's high 16bits.
  ;;   - AX: Dividend (DWORD) 's low 16bits.
  ;;   - CX: Divisor.
  ;;
  ;; Return value:
  ;;   - DX: High 16bits of the quotient.
  ;;   - AX: Low 16bits of the quotient.
  ;;   - CX: Remainder of the operation result.
  divdw:
    push bp
    mov bp, sp

    push ax
    push dx
    push cx

    ; int(H/N) * 0x10000
    mov dx, 0h
    mov ax, [bp - 4h]
    div cx ; DX: rem(H/N) * 0x10000; AX: int(H/N) => DX
    push ax

    ; [rem(H/N) * 0x10000 + L]/N
    mov ax, [bp - 2h]
    div cx ; DX: remainder; AX: int([rem(H/N) * 0x10000 + L]/N)

    ; remainder
    mov cx, dx

    ; quotient
    pop dx

    mov sp, bp
    pop bp
    ret

  ;; Function:
  ;;   - Name: wtoc
  ;;   - Description: Convert WORD type data to
  ;;                  decimal string ends with zero.
  ;;
  ;; Arguments:
  ;;   - AX: WORD type data
  ;;   - DS:SI: Start address of the string.
  ;;
  ;; Return value: None
  wtoc:
    push bp
    mov bp, sp

    push cx
    push si

    word_to_ascii:
      mov cx, 0ah
      mov dx, 0h
      div cx
      add dx, 30h
      push dx
      inc si
      mov cx, ax
      jcxz wtoc_ret
      jmp word_to_ascii
    wtoc_ret:
      sub si, [bp - 4h]
      mov di, [bp - 4h]
      add di, si
      mov byte ptr [bx + di], 0h
      mov cx, si
      mov si, [bp - 4h]
    wtoc_output:
      pop ax
      mov [bx + si], al
      inc si
      loop wtoc_output

      pop si
      pop cx
      mov sp, bp
      pop bp
      ret

  ;; Function:
  ;;   - Name: dtoc
  ;;   - Description: Convert DWORD type data to
  ;;                  decimal string ends with zero.
  ;;
  ;; Arguments:
  ;;   - DX:AX: DWORD type data
  ;;   - DS:SI: Start address of the string.
  ;;
  ;; Return value: None
  dtoc:
    push bp
    mov bp, sp

    push bx
    push cx
    push si

    mov si, 0h

    dword_to_ascii:
      mov cx, 0ah
      call divdw
      push cx
      push bx
      mov bx, bp
      sub bx, si
      sub bx, 8h
      mov di, ss:[bx]
      add di, 30h
      mov ss:[bx], di
      pop bx
      add si, 2h
      mov cx, ax
      jcxz dtoc_ret
      jmp dword_to_ascii

    dtoc_ret:
      push ax
      mov ax, si
      mov si, 2h
      div si
      mov cx, ax
      pop ax

      mov si, [bp - 6h]
    dtoc_output:
      pop ax
      mov [bx + si], al
      inc si
      loop dtoc_output

      pop si
      pop cx
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

    mov ax, 0b800h
    mov es, ax

    mov cx, 7d0h
    mov ax, 0700h
    mov di, 0h
    fill_space:
      mov es:[di], ax
      add di, 2h
      loop fill_space

      mov sp, bp
      pop bp
      ret
code ends

end start
