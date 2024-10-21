## 检测点 2.1

```
写出下列每条汇编指令执行后相关寄存器中的值：
mov ax, 62627    AX=__
mov ah, 31H      AX=__
mov al, 23H      AX=__
add ax, ax       AX=__
mov bx, 826CH    BX=__
mov cx, ax       CX=__
mov ax, bx       AX=__
add ax, bx       AX=__
mov al, bh       AX=__
mov ah, bl       AX=__
add ah, ah       AX=__
add al, 6        AX=__
add al, al       AX=__
mov ax, cx       AX=__
```

```
mov ax, 62627    AX=0xF4A3
mov ah, 31H      AX=0x31A3
mov al, 23H      AX=0x3123
add ax, ax       AX=0x6246
mov bx, 826CH    BX=0x826C
mov cx, ax       CX=0x6246
mov ax, bx       AX=0x826C
add ax, bx       AX=0x04D8
mov al, bh       AX=0x0482
mov ah, bl       AX=0x6C82
add ah, ah       AX=0xD882
add al, 6        AX=0xD888
add al, al       AX=0xD810
mov ax, cx       AX=0x6246
```

```
只能使用目前学过的汇编指令，最多使用 4 条指令，编程计算 2 的 4 次方。
```

```asm
mov al, 0x2
add al, al
add al, al
add al, al
```
