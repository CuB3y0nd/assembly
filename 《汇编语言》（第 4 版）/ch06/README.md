## 检测点 6.1

```
（1）下面的程序实现依次用内存 0:0~0:15 单元中的内容改写程序中的数据，完成程序：

assume cs:codesg
codesg segment
  dw 0x0123, 0x0456, 0x0789, 0x0abc, 0x0def, 0x0fed, 0x0cba, 0x0987
start: mov ax, 0x0
       mov ds, ax
       mov bx, 0x0

       mov cx, 0x8
    s: mov ax, [bx]
       ________
       add bx, 0x2
       loop s

       mov ax, 0x4c00
       int 0x21
codesg ends
end start
```

```asm
assume cs:codesg
codesg segment
  dw 0x0123, 0x0456, 0x0789, 0x0abc, 0x0def, 0x0fed, 0x0cba, 0x0987
start: mov ax, 0x0
       mov ds, ax
       mov bx, 0x0

       mov cx, 0x8
    s: mov ax, [bx]
       mov cs:[bx], ax
       add bx, 0x2
       loop s

       mov ax, 0x4c00
       int 0x21
codesg ends
end start
```

```
（2）下面的程序实现依次用内存 0:0~0:15 单元中的内容改写在程序中的数据，数据的传送用栈来进行。栈空间设置在程序内，完成程序：

assume cs:codesg
codesg segment
  dw 0x0123, 0x0456, 0x0789, 0x0abc, 0x0def, 0x0fed, 0x0cba, 0x0987
  dw 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
start: mov ax, ____
       mov ss, ax
       mov sp, ____

       mov ax, 0x0
       mov ds, ax
       mov bx, 0x0
       mov cx, 0x8
    s: push [bx]
       ________
       add bx, 0x2
       loop s

       mov ax, 0x4c00
       int 0x21
codesg ends
end start
```

```asm
assume cs:codesg
codesg segment
  dw 0x0123, 0x0456, 0x0789, 0x0abc, 0x0def, 0x0fed, 0x0cba, 0x0987
  dw 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
start: mov ax, cs
       mov ss, ax
       mov sp, 0x24

       mov ax, 0x0
       mov ds, ax
       mov bx, 0x0
       mov cx, 0x8
    s: push [bx]
       pop cs:[bx]
       add bx, 0x2
       loop s

       mov ax, 0x4c00
       int 0x21
codesg ends
end start
```

## 实验 5：编写、调试具有多个段的程序

略
