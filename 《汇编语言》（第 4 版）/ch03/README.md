## 检测点 3.1

```
（1）在 Debug 中，用 "d 0:0 1f" 查看内存，结果如下。
0000:0000  70 80 F0 30 EF 60 30 E2-00 80 80 12 66 20 22 60
0000:0010  62 26 E6 D6 CC 2E 3C 3B-AB BA 00 00 26 06 66 88

下面的程序执行前，AX=0，BX=0，写出每条汇编指令执行完后相关寄存器中的值。

mov ax, 1
mov ds, ax
mov ax, [0000]  AX=__
mov bx, [0001]  BX=__
mov ax, bx      AX=__
mov ax, [0000]  AX=__
mov bx, [0002]  BX=__
add ax, bx      AX=__
add ax, [0004]  AX=__
mov ax, 0       AX=__
mov al, [0002]  AX=__
mov bx, 0       BX=__
mov bl, [000C]  BX=__
add al, bl      AX=__

提示：注意 ds 的设置。
```

```
mov ax, 1
mov ds, ax
mov ax, [0000]  AX=0x2662
mov bx, [0001]  BX=0xE626
mov ax, bx      AX=0xE626
mov ax, [0000]  AX=0x2662
mov bx, [0002]  BX=0xD6E6
add ax, bx      AX=0xFD48
add ax, [0004]  AX=0x2C14
mov ax, 0       AX=0x0000
mov al, [0002]  AX=0x00E6
mov bx, 0       BX=0x0000
mov bl, [000C]  BX=0x0026
add al, bl      AX=0x000C
```

```
（2）内存中的情况如图 3.6 所示。

各寄存器的初始值：CS=2000H, IP=0, DS=1000H, AX=0, BX=0;

1. 写出 CPU 执行的指令序列（用汇编指令写出）。
2. 写出 CPU 执行每条指令后，CS、IP 和相关寄存器中的值。
3. 再次体会：数据和程序有区别吗？如何确定内存中的信息哪些是数据，哪些是程序？
```

```
mov ax, 0x6622  CS: 2000 IP: 0003 DS: 0x1000 AX: 0x6622 BX: 0x0000
jmp 0ff0:0100   CS: 0ff0 IP: 0100 DS: 0x1000 AX: 0x6622 BX: 0x0000
mov ax, 0x2000  CS: 0ff0 IP: 0103 DS: 0x1000 AX: 0x2000 BX: 0x0000
mov ds, ax      CS: 0ff0 IP: 0105 DS: 0x2000 AX: 0x2000 BX: 0x0000
mov ax [0008]   CS: 0ff0 IP: 0108 DS: 0x2000 AX: 0xC389 BX: 0x0000
mov ax, [0002]  CS: 0ff0 IP: 010B DS: 0x2000 AX: 0xEA66 BX: 0x0000

数据和程序没有区别。通过设置数据段和代码段来区分数据和指令。
```
