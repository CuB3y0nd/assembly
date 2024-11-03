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
