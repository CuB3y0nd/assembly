assume cs:code

stack segment
  db 16 dup (0)
stack ends

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

code segment
  start:        mov ax, stack
                mov ss, ax
                mov sp, 10h

                mov ax, data
                mov ds, ax

                mov ax, table
                mov es, ax

                mov si, 0h
                mov di, 54h
                mov bx, 0a8h
                mov bp, 0h

                mov cx, 15h
  create_table: ; year
                push ds:[si]
                pop es:[bp]
                push ds:[si + 2h]
                pop es:[bp + 2h]

                ; income
                mov ax, ds:[di]
                mov dx, ds:[di + 2h]
                mov es:[bp + 5h], ax
                mov es:[bp + 7h], dx

                ; employees
                push ds:[bx]
                pop es:[bp + 0ah]

                ; avg_income
                div word ptr ds:[bx]
                mov es:[bp + 0dh], ax

                add si, 4h
                add di, 4h
                add bx, 2h
                add bp, 10h

                loop create_table

                mov ax, 4c00h
                int 21h
code ends

end start
