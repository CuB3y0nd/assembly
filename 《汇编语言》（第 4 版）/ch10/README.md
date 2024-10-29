## 检测点 10.1

```
补全程序，实现从内存 1000:0000 处开始执行指令。

assume cs:code

stack segment
  db 10h dup (0h)
stack ends

code segment
  start: mov ax, stack
         mov ss, ax
         mov sp, 10h
         mov ax, ____
         push ax
         mov ax, ____
         push ax
         retf
code ends

end start
```

```asm
assume cs:code

stack segment
  db 10h dup (0h)
stack ends

code segment
  start: mov ax, stack
         mov ss, ax
         mov sp, 10h
         mov ax, 1000h
         push ax
         mov ax, 0h
         push ax
         retf
code ends

end start
```

## 检测点 10.2

```
下面的程序执行后，AX 中的数值为多少？

内存地址    机器码      汇编指令
1000:0      B8 00 00    mov ax, 0h
1000:3      E8 01 00    call s
1000:6      40          inc ax
1000:7      58          s: pop ax
```

- AX: 0x0006

## 检测点 10.3

```
下面的程序执行后，AX 中的数值为多少？

内存地址    机器码            汇编指令
1000:0      B8 00 00          mov ax, 0h
1000:3      9A 09 00 00 10    call far ptr s
1000:8      40                inc ax
1000:9      58                s: pop ax
                              add ax, ax
                              pop bx
                              add ax, bx
```

- AX: 0x06AD
