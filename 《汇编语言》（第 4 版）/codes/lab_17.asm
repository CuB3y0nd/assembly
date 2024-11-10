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
    nop

    mov ax, 4c00h
    int 21h

    ;; Function:
    ;;   - Name: int_7c_handler
    ;;   - Description: A simple interrupt handler for more convenient
    ;;                  read/write operation.
    ;;
    ;; Arguments:
    ;;   - AH: Sub handler number. Range: [0h ~ 1h]
    ;;   - DX: Logical sector number that you want to read/write.
    ;;   - ES:BX: Store the start address of the data you want
    ;;            read out or write into.
    ;;
    ;; Sub handlers:
    ;;   - 0x0: Read disk.
    ;;   - 0x1: Write disk.
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

        options dw read, write

        perform:
          cmp ah, 1h
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
      ;;   - Name: calc_chs
      ;;   - Description: Calculate CHS from given logical sector number.
      ;;
      ;; Arguments:
      ;;   - DX: Logical sector number that you want to read/write.
      ;;
      ;; Return value:
      ;;   - CH: Cylinder number.
      ;;   - CL: Sector number.
      ;;   - DH: Head number.
      calc_chs:
        push bp
        mov bp, sp

        ;; Logical sector number (LSN) = (Head * 80 + Cylinder) * 18 + Sector - 1
        ;; Head = int(LSN / 1440)
        ;; Cylinder = int(rem(LSN / 1440) / 18)
        ;; Sector = rem(rem(LSN / 1440) / 18) + 1

        ; Head = int(LSN / 1440)
        mov ax, dx
        xor dx, dx
        mov bx, 5a0h
        div bx
        push ax

        ; Cylinder = int(rem(LSN / 1440) / 18)
        mov ax, dx
        xor dx, dx
        mov bx, 12h
        div bx
        push ax

        ; Sector = rem(rem(LSN / 1440) / 18) + 1
        mov ax, dx
        inc ax
        push ax

        ; result
        mov dh, [bp - 2h] ; Head
        mov ch, [bp - 4h] ; Cylinder
        mov cl, [bp - 6h] ; Sector

        mov sp, bp
        pop bp
        ret

      ;; Function:
      ;;   - Name: read
      ;;   - Description: Read disk.
      ;;
      ;; Arguments:
      ;;   - DX: Logical sector number that you want to read/write.
      ;;   - ES:BX: Store the start address of the data you want
      ;;            read out or write into.
      ;;
      ;; Return value: None
      read:
        push bp
        mov bp, sp

        call calc_chs

        mov ah, 2h
        mov al, 1h
        mov dl, 81h
        int 13h

        mov sp, bp
        pop bp
        ret

      ;; Function:
      ;;   - Name: write
      ;;   - Description: Write disk.
      ;;
      ;; Arguments:
      ;;   - DX: Logical sector number that you want to read/write.
      ;;   - ES:BX: Store the start address of the data you want
      ;;            read out or write into.
      ;;
      ;; Return value: None
      write:
        push bp
        mov bp, sp

        call calc_chs

        mov ah, 3h
        mov al, 1h
        mov dl, 81h
        int 13h

        mov sp, bp
        pop bp
        ret

      int_7c_handler_end:
        nop
code ends

end start
