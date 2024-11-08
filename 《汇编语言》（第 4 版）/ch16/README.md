## 检测点 16.1

```
下面的程序将 code 段中 a 处的 8 个数据累加，结果存储到 b 处的双字中，补全程序。

assume cs:code

code segment
  a dw 1, 2, 3, 4, 5, 6, 7, 8
  b dd 0

  start:
    mov si, 0h
    mov cx, 8h

  s:
    mov ax, ____
    add ____, ax
    adc ____, 0h
    add si, ____
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start
```

```asm
assume cs:code

code segment
  a dw 1, 2, 3, 4, 5, 6, 7, 8
  b dd 0

  start:
    mov si, 0h
    mov cx, 8h

  s:
    mov ax, a[si]
    add word ptr b[0], ax
    adc word ptr b[2], 0h
    add si, 2h
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start
```

## 检测点 16.2

```
下面的程序将 data 段中 a 处的 8 个数据累加，结果存储到 b 处的字中，补全程序。

assume cs:code es:data

data segment
  a db 1, 2, 3, 4, 5, 6, 7, 8
  b dw 0
data ends

code segment
  start:
    ________
    ________
    mov si, 0h
    mov cx, 8h

  s:
    mov al, a[si]
    mov ah, 0h
    add b, ax
    inc si
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start
```

```asm
assume cs:code, es:data

data segment
  a db 1, 2, 3, 4, 5, 6, 7, 8
  b dw 0
data ends

code segment
  start:
    mov ax, data
    mov es, ax
    mov si, 0h
    mov cx, 8h

  s:
    mov al, a[si]
    mov ah, 0h
    add b, ax
    inc si
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start
```
