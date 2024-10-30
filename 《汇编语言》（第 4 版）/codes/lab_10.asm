assume cs:code

code segment
       start: ; TODO

              mov ax, 4c00h
              int 21h

              ; Function:
              ;   Name: print
              ;   Description: Print string which ends with zero
              ;                with given style in special position.
              ;
              ; Arguments:
              ;   DH: Row address. Range: [0 ~ 24]
              ;   DL: Column address. Range: [0 ~ 79]
              ;   CL: Style of the ASCII code.
              ;
              ; Return value: None
       print: push bp
              mov bp, sp

              push dx
              push cx

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
  print_char: mov cl, ds:[si]
              jcxz return
              mov es:[di], cl
              mov cl, [bp - 4h]
              mov es:[di + 1h], cl
              inc si
              add di, 2h
              jmp short print_char
      return: mov sp, bp
              pop bp
              ret

              ; Function:
              ;   Name: divdw
              ;   Description: Divide operation without overflow.
              ;
              ; General formula:
              ;   X/N = int(H/N) * 0x10000 + [rem(H/N) * 0x10000 + L]/N
              ;
              ; Placeholder description:
              ;   X: Dividend. Range: [0x0 ~ 0xffffffff]
              ;   N: Divisor. Range: [0x0 ~ 0xffff]
              ;   H: X (Dividend) 's high 16bits. Range: [0x0 ~ 0xffff]
              ;   L: X (Dividend) 's low 16bits. Range: [0x0 ~ 0xffff]
              ;
              ; Arguments:
              ;   DX: Dividend (DWORD) 's high 16bits.
              ;   AX: Dividend (DWORD) 's low 16bits.
              ;   CX: Divisor.
              ;
              ; Return value:
              ;   DX: High 16bits of the quotient.
              ;   AX: Low 16bits of the quotient.
              ;   CX: Remainder of the operation result.
       divdw: push bp
              mov bp, sp

              push ax
              push dx
              push cx

              ; int(H/N) * 0x10000
              mov dx, 0h
              mov ax, [bp - 4h]
              ; DX: rem(H/N); AX: int(H/N)
              div cx
              push dx
              mov bx, 8000h
              mul bx
              mov bx, 2h
              mul bx

              push dx
              push ax

              ; [rem(H/N) * 0x10000 + L]/N
              mov ax, [bp - 8h]
              mul bx
              mov bx, 8000h
              mul bx
              add ax, [bp - 2h]
              div word ptr [bp - 6h]

              ; remainder
              mov cx, dx

              ; quotient
              add dx, [bp - 0ah]
              add ax, [bp - 0ch]

              mov sp, bp
              pop bp
              ret
        dtoc: ; TODO
code ends

end start

; TEST: print
;assume ds:data, cs:code
;
;data segment
;  db 'Welcome to masm!', 0
;data ends
;
;code segment
;  start: mov dh, 8
;         mov dl, 3
;         mov cl, 2h
;         mov ax, data
;         mov ds, ax
;         mov si, 0h
;         call print
;
;         mov ax, 4c00h
;         int 21h
;
;  put print function here
;code ends

; TEST: divdw
;assume cs:code
;
;code segment
;  start: mov ax, 4240h
;         mov dx, 000fh
;         mov cx, 0ah
;         call divdw
;
;         mov ax, 4c00h
;         int 21h
;
;  put divdw function here
;code ends
