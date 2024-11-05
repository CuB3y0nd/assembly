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
