## 检测点 11.1

```
写出下面每条指令执行后，ZF、PF、SF 等标志位的值。

sub al, al    ZF=____ PF=____ SF=____
mov al, 1h    ZF=____ PF=____ SF=____
push ax       ZF=____ PF=____ SF=____
pop bx        ZF=____ PF=____ SF=____
add al, bl    ZF=____ PF=____ SF=____
add al, 0ah   ZF=____ PF=____ SF=____
mul al        ZF=____ PF=____ SF=____
```

```
sub al, al    ZF=1 PF=1 SF=0
mov al, 1h    ZF=1 PF=1 SF=0
push ax       ZF=1 PF=1 SF=0
pop bx        ZF=1 PF=1 SF=0
add al, bl    ZF=0 PF=0 SF=0
add al, 0ah   ZF=0 PF=1 SF=0
mul al        ZF=0 PF=1 SF=0
```

## 检测点 11.2

```
写出下面每条指令执行后，ZF、PF、SF、CF、OF 等标志位的值。

                CF    OF    SF    ZF    PF
sub al, al
mov al, 10h
add al, 90h
mov al, 80h
add al, 80h
mov al, 0fch
add al, 05h
mov al, 7dh
add al, 0bh
```

```
                CF    OF    SF    ZF    PF
sub al, al      0     0     0     1     1
mov al, 10h     0     0     0     1     1
add al, 90h     0     0     1     0     1
mov al, 80h     0     0     1     0     1
add al, 80h     1     1     0     1     1
mov al, 0fch    1     1     0     1     1
add al, 05h     1     0     0     0     0
mov al, 7dh     1     0     0     0     0
add al, 0bh     0     1     1     0     1
```

## 检测点 11.3

```
（1）补全下面的程序，统计 F000:0 处 32 个字节中，大小在 [32, 128] 的数据的个数。

    mov ax, 0f000h
    mov ds, ax

    mov bx, 0
    mov dx, 0
    mov cx, 32
 s: mov al, [bx]
    cmp al, 32
    ________
    cmp al, 128
    ________
    inc dx
s0: inc bx
    loop s
```

```asm
    mov ax, 0f000h
    mov ds, ax

    mov bx, 0
    mov dx, 0
    mov cx, 32
 s: mov al, [bx]
    cmp al, 32
    jb s0
    cmp al, 128
    ja s0
    inc dx
s0: inc bx
    loop s
```

```
（2）补全下面的程序，统计 F000:0 处 32 个字节中，大小在 (32, 128) 的数据的个数。

    mov ax, 0f000h
    mov ds, ax

    mov dx, 0
    mov dx, 0
    mov cx, 32
 s: mov al, [bx]
    cmp al, 32
    ________
    cmp al, 128
    ________
    inc dx
s0: inc bx
    loop s
```

```asm
    mov ax, 0f000h
    mov ds, ax

    mov bx, 0
    mov dx, 0
    mov cx, 32
 s: mov al, [bx]
    cmp al, 32
    jna s0
    cmp al, 128
    jnb s0
    inc dx
s0: inc bx
    loop s
```

## 检测点 11.4

```
下面的程序执行后 AX=?

mov ax, 0
push ax
popf
mov ax, 0fff0h
add ax, 0010h
pushf
pop ax
and al, 11000101B
and ah, 00001000B
```

- AX: `0x45`
