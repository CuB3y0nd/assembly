assume cs:code

code segment
  start:
    mov ax, 4240h
    mov dx, 000fh
    mov cx, 0ah
    call divdw

    mov ax, 4c00h
    int 21h

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
code ends

end start
