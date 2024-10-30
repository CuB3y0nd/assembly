assume ds:data, cs:code

code segment
         start: ; TOOD
      show_str: mov ax, 0b800h
                mov es, ax

                ; line address
                mov ax, 0a0h
                mul dh
                push ax

                ; column address
                mov al, 2h
                mul dl
                push ax

                pop ax
                pop di
                add di, ax

                mov ch, 0h
         print: mov cl, ds:[si]
                jcxz show_str_ret
                mov es:[di], cl
                mov bp, sp
                mov al, [bp + 2h]
                mov byte ptr es:[di + 1h], al
                inc si
                add di, 2h
                jmp short print
  show_str_ret: ret
                pop cx
         divdw:
          dtoc:
code ends

end start

; TEST: show_str
;assume ds:data, cs:code
;data segment
;  db 'Welcome to masm!', 0
;data ends
;
;code segment
;  start: mov dh, 0bh
;         mov dl, 27h
;         mov cl, 2h
;         mov ax, data
;         mov ds, ax
;         mov si, 0h
;         push cx
;         call show_str
;
;         pop cx
;
;         mov ax, 4c00h
;         int 21h
;  put show_str function here
;code ends
