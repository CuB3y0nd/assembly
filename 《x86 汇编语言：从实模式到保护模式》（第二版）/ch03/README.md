## 检测点 3.1

```
一个字含有（）字节和（）比特？一个双字含有（）字节、（）个字和（）比特？
```

一个字含有 $2$ 字节和 $16$ 比特。一个双字含有 $\text{4 字节、2 个字 和 32 比特}$。

```
二进制数 10000000 中，位（）的那个比特是「1」，也就是第（）位。它是最低位还是最高位？
```

二进制数 10000000 中，位 $7$ 的那个比特是「1」，也就是第 $8$ 位。它是最高位。

```
一个存储器的容量是 16 字节，地址范围为（）～（）。用该存储器保存字数据时，可存放（）个字，这些字的地址分别是（），保存双字呢？
```

一个存储器的容量是 16 字节，地址范围为 $(0)\_{H}$ ~ $(F)\_{H}$。用该存储器保存字数据时，可存放 $8$ 个字，这些字的地址分别是 $(0)\_{H}、(2)\_{H}、(4)\_{H}、(6)\_{H}、(8)\_{H}、(A)\_{H}、(C)\_{H}、(E)\_{H}$。保存双字时地址分别是 $(0)\_{H}、(4)\_{H}、(8)\_{H}、(C)\_{H}$。

## 检测点 3.2

```
INTEL 8086 有哪几款通用寄存器？这些寄存器的长度是几比特？几字节？
```

INTEL 8086 的通用寄存器分别有 $AX、BX、CX、DX、SI、DI、BP、SP$，这些寄存器的长度均为 $\text{16 比特，2 字节}$。

```
如果向寄存器 DH 写入数字 08H，向寄存器 DL 写入数字 3CH，则寄存器 DX 的内容是什么？
```

如果向寄存器 DH 写入数字 08H，向寄存器 DL 写入数字 3CH，则寄存器 DX 的内容是 $(083C)_{H}$

## 检测点 3.3

```
INTEL 8086 处理器有（）个 16 位通用寄存器。分别是（）。其中，有些还可以分开来作为两个独立的 8 位寄存器来用，这几个 8 位寄存器分别是（）。
```

- INTEL 8086 处理器有 $8$ 个 16 位通用寄存器。分别是 $AX、BX、CX、DX、SI、DI、BP、SP$。其中，有些还可以分开来作为两个独立的 8 位寄存器来用，这几个 8 位寄存器分别是 $AH、AL、BH、BL、CH、CL、DH、DL$。

```
选择题（可多选）：INTEL 8086 处理器取指令时，使用段寄存器（）和指令指针寄存器（）。方法是，将段寄存器的值（），加上指令指针寄存器的当前值，形成物理地址访问内存。

A. CS    B. DS    C. IP    D. 左移 4 位    E. 右移 4 位    F. 乘以 16    G. 除以 10H
```

- $A、C、D/F$

```
物理地址 132FEH 对应的逻辑地址是（可多选）：

A. 132FH:000EH    B. 1300H:02FEH    C. 1000H:32FEH    D. 1320H:00FEH    E. 102FH:03E0H    F. 0FE0H:34FEH
```

- $A、B、C、D、F$

## 第 3 章习题

```
在段与段之间互不重叠的前提下，1MB 内存可以完整的划分为多少个 16KB 的段？
```

$$
\text{在段与段之间互不重叠的前提下，1MB 内存可以完整的划分为 1MB / 16KB = 64 个 16KB 的段。}
$$

```
数据段寄存器 DS 的值为 25BCH 时，计算 INTEL 8086 可以访问的最大物理地址范围。
```

$$
\begin{aligned}
& (25BC0)\_{H} + (FFFF)\_{H} = (35BBF)\_{H} \\
& 范围：[(25BC0)\_{H}, (35BBF)\_{H}]
\end{aligned}
$$
