## 检测点 6.1

```
（1）下面的程序实现依次用内存 0:0~0:15 单元中的内容改写程序中的数据，完成程序：

assume cs:codesg
codesg segment
  dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
start: mov ax, 0h
       mov ds, ax
       mov bx, 0h

       mov cx, 8h
    s: mov ax, [bx]
       ________
       add bx, 2h
       loop s

       mov ax, 4c00h
       int 21h
codesg ends
end start
```

```asm
assume cs:codesg
codesg segment
  dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
start: mov ax, 0h
       mov ds, ax
       mov bx, 0h

       mov cx, 8h
    s: mov ax, [bx]
       mov cs:[bx], ax
       add bx, 2h
       loop s

       mov ax, 4c00h
       int 21h
codesg ends
end start
```

```
（2）下面的程序实现依次用内存 0:0~0:15 单元中的内容改写在程序中的数据，数据的传送用栈来进行。栈空间设置在程序内，完成程序：

assume cs:codesg
codesg segment
  dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
  dw 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
start: mov ax, ____
       mov ss, ax
       mov sp, ____

       mov ax, 0h
       mov ds, ax
       mov bx, 0h
       mov cx, 8h
    s: push [bx]
       ________
       add bx, 2h
       loop s

       mov ax, 4c00h
       int 21h
codesg ends
end start
```

```asm
assume cs:codesg
codesg segment
  dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
  dw 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
start: mov ax, cs
       mov ss, ax
       mov sp, 24h

       mov ax, 0h
       mov ds, ax
       mov bx, 0h
       mov cx, 8h
    s: push [bx]
       pop cs:[bx]
       add bx, 2h
       loop s

       mov ax, 4c00h
       int 21h
codesg ends
end start
```

## 实验 5：编写、调试具有多个段的程序

略
