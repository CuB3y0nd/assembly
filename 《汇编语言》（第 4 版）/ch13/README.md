## 检测点 13.1

```
（1）在上面的例子中，我们用 7ch 中断例程实现 loop 的功能，则上面的 7ch 中断例程所能进行的最大转移位移是多少？
```

- `0xFFFF`

```
（2）用 7ch 中断例程完成 jmp near ptr s 指令的功能，用 bx 向中断例程传送转移位移。

应用举例：在屏幕的第 12 行，显示 data 段中以 0 结尾的字符串。

assume cs:code

data segment
  db 'conversation', 0
data ends

code segment
  start:
    mov ax, data
    mov ds, ax
    mov si, 0h
    mov ax, 0b800h
    mov es, ax
    mov di, 12*160

  s:
    cmp byte ptr [si], 0h
    je ok
    mov al, [si]
    mov es:[di], al
    inc si
    add di, 2h
    mov bx, offset s - offset ok
    int 7ch

  ok:
    mov ax, 4c00h
    int 21h
code ends

end start
```

[源码](../codes/quiz_13-1.asm)

## 检测点 13.2

```
判断下面说法的正误：

（1）我们可以编程改变 FFFF:0 处的指令，使得 CPU 不去执行 BIOS 中的硬件系统检测和初始化程序。

（2）int 19h 中断例程，可以由 DOS 提供。
```

- 错。`FFFF:0` 属于 `ROM`。
- 错。`int 19h` 用来引导 `DOS`。`DOS` 还没被加载起来之前什么都提供不了。

## 实验 13：编写、应用中断例程

```
（1）编写并安装 int 7ch 中断例程，功能为显示一个用 0 结尾的字符串，中断例程安装在 0:200 处。

参数：(dh) = 行号，(dl) = 列号，(cl) = 颜色，DS:SI 指向字符串首地址。

以上中断例程安装成功后，对下面的程序进行单步跟踪，尤其注意观察 int、iret 指令执行前后 CS、IP 和栈中的状态。

assume cs:code

data segment
  db "welcome to masm! ", 0
data ends

code segment
  start:
    mov dh, 10
    mov dl, 10
    mov cl, 2h
    mov ax, data
    mov ds, ax
    mov si, 0
    int 7ch

    mov ax, 4c00h
    int 21h
code ends

end start
```

[源码](../codes/lab_13-1.asm)

```
（2）编写并安装 int 7ch 中断例程，功能为完成 loop 指令的功能。

参数：(cx) = 循环次数，(bx) = 位移。

以上中断例程安装成功后，对下面的程序进行单步跟踪，尤其注意观察 int、iret 指令执行前后 CS、IP 和栈中的状态。

在屏幕中间显示 80 个 "!"。

assume cs:code

code segment
  start:
    mov ax, 0b800h
    mov es, ax
    mov di, 160*12
    mov bx, offset s - offset se
    mov cx, 80
  s:
    mov byte ptr es:[di], '!'
    add di, 2
    int 7ch
  se:
    nop

    mov ax, 4c00h
    int 21h
code ends

end start
```

[源码](../codes/lab_13-2.asm)

```
（3）下面的程序，分别在屏幕的第 2、4、6、8 行显示 4 句英文诗，补全程序。

assume cs:code

code segment
  s1:  db 'Good, better, best,', '$'
  s2:  db 'Never let it rest,', '$'
  s3:  db 'Till good is better,', '$'
  s4:  db 'And better, best.', '$'
  s:   dw offset s1, offset s2, offset s3, offset s4
  row: db 2, 4, 6, 8

  start:
    mov ax, cs
    mov ds, ax
    mov bx, offset s
    mov si, offset row
    mov cx, 4

  ok:
    mov bh, 0
    mov dh, ____
    mov dl, 0
    mov ah, 2
    int 10h

    mov dx, ____
    mov ah, 9
    int 21h
    ________
    ________
    loop ok

    mov ax, 4c00h
    int 21h
code ends

end start

完成后编译运行，体会其中的编程思想。
```

```
[si]
[bx]
inc si
add bx, 2h
```
