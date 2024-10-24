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

## 检测点 2.2

```
（1）给定段地址为 0001H，仅通过变化偏移地址寻址，CPU 的寻址范围为__到__。
（2）有一数据存放在内存 20000H 单元中，现给定段地址为 SA，若想用偏移地址寻址到此单元。则 SA 应满足的条件是：最小为__，最大为__。
（2）提示，反过来思考一下，当段地址给定为多少，CPU 无论怎么变化偏移地址都无法寻到 20000H 单元？
```

- `0x00010` - `0x1000F`
- Max: `0x2000` ; Min: `0x1001`

## 检测点 2.3

```
下面的 3 条指令执行后，CPU 几次修改 IP？都是在什么时候？最后 IP 中的值是多少？

mov ax, bx
sub ax, ax
jmp ax
```

- 四次修改 IP

1. 读取 `mov ax, bx` 后
2. 读取 `sub ax, ax` 后
3. 读取 `jmp ax` 后
4. 执行 `jmp ax` 后

- 最后 IP 中的值为 `0x0000`

## 实验 1：查看 CPU 和内存，用机器指令和汇编指令编程

### 实验任务

```
（1）使用 Debug，将下面的程序写入内存，逐条执行，观察每条指令执行后 CPU 中相关寄存器中的内容的变化。
```
