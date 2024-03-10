## 检测点 7.1

```
选择填空：movsb 指令每次传送一（），movsw 指令每次传送一个（）。原始数据在段内的偏移地址在寄存器（）中，要传送的目标位置的偏移地址在寄存器（）中。如果要连续传送多个字或字节，则需要（）前缀，在寄存器（）中设置传送的次数，并设置传送的方向。其中，（）指令指示正向传送，（）指令指示反向传送。反向传送时，每传送一次，SI 和 DI 的内容将（）。

A. 字节  B. 字  C. DI  D. SI  E. CX  F. rep  G. 减小  H. std  I. cld  J. 增大
```

 - $\text{A、B、D、C、F、E、I、H、G}$

## 检测点 7.2

```
选择题：下面哪些指令是错误的，为什么？

A. add ax, [bx]  B. mov ax, [si]   C. mov ax, [cx]   D. mov dx, [di]
E. mov dx, [ax]  F. inc byte [di]  G. div word [bx]
```

 - $\text{C、E：在 8086 处理器上，如果要用寄存器来提供偏移地址，只能使用寄存器 BX、SI、DI、BP。}$

## 检测点 7.3

```
假如以下声明的是有符号数，那么，其中的负数是（）。

data0 db 0xf0, 0x05, 0x66, 0xff, 0x81
data1 dw 0xfff, 0xffff, 0x8b, 0x8a08
```

 - $\text{0xf0、0xff、0x81、0xffff、0x8a08}$

