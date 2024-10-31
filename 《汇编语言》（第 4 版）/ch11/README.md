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
