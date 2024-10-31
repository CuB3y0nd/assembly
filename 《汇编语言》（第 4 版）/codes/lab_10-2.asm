assume cs:code

code segment
    start: mov ax, 4240h
           mov dx, 000fh
           mov cx, 0ah
           call divdw

           mov ax, 4c00h
           int 21h

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
code ends

end start
