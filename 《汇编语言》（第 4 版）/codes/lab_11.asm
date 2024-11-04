assume cs:code

data segment
  db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
  start:
    mov ax, data
    mov ds, ax
    mov si, 0h
    call to_upper_case

    mov ax, 4c00h
    int 21h

  ;; Function:
  ;;   - Name: to_upper_case
  ;;   - Description: Convert all lower case letters in a string
  ;;                  which ends with zero to upper case form.
  ;;
  ;; Arguments:
  ;;   - DS:SI: Start address of the string.
  ;;
  ;; Return value: None
  to_upper_case:
    push bp
    mov bp, sp

    push cx

    mov ch, 0h
    judge:
      mov cl, [si]
      jcxz letterc_ret
      cmp cl, 97
      jb illegal_char
      cmp cl, 122
      ja illegal_char

      sub cl, 32
      mov [si], cl

    illegal_char:
      inc si
      loop judge

    letterc_ret:
      pop cx

      mov sp, bp
      pop bp
      ret
code ends

end start
