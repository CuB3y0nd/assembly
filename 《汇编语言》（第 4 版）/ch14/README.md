## 检测点 14.1

```
（1）编程，读取 CMOS RAM 的 2 号单元的内容。
```

```asm
mov al, 2h
out 70h, al
in al, 71h
```

```
（2）编程，向 CMOS RAM 的 2 号单元写入 0。
```

```asm
mov al, 2h
out 70h, al
mov al, 0h
out 71h, al
```

## 检测点 14.2

```
编程，用加法和位移指令计算 (AX) = (AX) * 10。

提示，(AX) * 10 = (AX) * 2 + (AX) * 8
```

```asm
assume cs:code

code segment
  start:
    mov ax, 5h
    mov bx, ax
    shl ax, 1h
    mov cl, 3h
    shl bx, cl
    add ax, bx

    mov ax, 4c00h
    int 21h
code ends

end start
```
