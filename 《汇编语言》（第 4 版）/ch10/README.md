## 检测点 10.1

```
补全程序，实现从内存 1000:0000 处开始执行指令。

assume cs:code

stack segment
  db 10h dup (0h)
stack ends

code segment
  start: mov ax, stack
         mov ss, ax
         mov sp, 10h
         mov ax, ____
         push ax
         mov ax, ____
         push ax
         retf
code ends

end start
```

```asm
assume cs:code

stack segment
  db 10h dup (0h)
stack ends

code segment
  start: mov ax, stack
         mov ss, ax
         mov sp, 10h
         mov ax, 1000h
         push ax
         mov ax, 0h
         push ax
         retf
code ends

end start
```

## 检测点 10.2

```
下面的程序执行后，AX 中的数值为多少？

内存地址    机器码      汇编指令
1000:0      B8 00 00    mov ax, 0h
1000:3      E8 01 00    call s
1000:6      40          inc ax
1000:7      58          s: pop ax
```

- AX: `0x0006`

## 检测点 10.3

```
下面的程序执行后，AX 中的数值为多少？

内存地址    机器码            汇编指令
1000:0      B8 00 00          mov ax, 0h
1000:3      9A 09 00 00 10    call far ptr s
1000:8      40                inc ax
1000:9      58                s: pop ax
                              add ax, ax
                              pop bx
                              add ax, bx
```

- AX: `0x1010`

## 检测点 10.4

```
下面的程序执行后，AX 中的数值为多少？

内存地址    机器码      汇编指令
1000:0      B8 06 00    mov ax, 6h
1000:3      FF D0       call ax
1000:5      40          inc ax
1000:6                  mov bp, sp
                        add ax, [bp]
```

- AX: `0x000B`

## 检测点 10.5

```
（1）下面的程序执行后，AX 中的数值为多少？（注意：用 call 指令的原理来分析，不要在 Debug 中单步跟踪来验证你的结论。对于此程序，在 Debug 中单步跟踪的结果，不能代表 CPU 的实际执行结果。）

assume cs:code

stack segment
  dw 8h dup (0h)
stack ends

code segment
  start: mov ax, stack
         mov ss, ax
         mov sp, 10h
         mov ds, ax
         mov ax, 0h
         call word ptr ds:[0eh]
         inc ax
         inc ax
         inc ax
         mov ax, 4c00h
         int 21h
code ends

end start
```

执行 `call word ptr ds:[0eh]` 时，先将 `IP` 入栈，再 `jmp word ptr ds:[0eh]`，其中，`ds:[0eh]` 的值为 `0x0011`，跳转后执行三次 `inc ax`。最终 `AX=0x3`。

```
（2）下面的程序执行后，AX 和 BX 中的数值为多少？

assume cs:code

data segment
  dw 8h dup (0h)
data ends

code segment
  start: mov ax, data
         mov ss, ax
         mov sp, 10h
         mov word ptr ss:[0h], offset s
         mov ss:[2h], cs
         call dword ptr ss:[0h]
         nop
      s: mov ax, offset s
         sub ax, ss:[0ch]
         mov bx, cs
         sub bx, ss:[0eh]
         mov ax, 4c00h
         int 21h
code ends

end start
```

- AX: `0x0001`; BX: `0x0000`

## 实验 10：编写子程序

- [实验 10.1](../codes/lab_10-1.asm)
- [实验 10.2](../codes/lab_10-2.asm)

> [!NOTE]
> 实验 10.1 的代码中我把书中给定的的子程序名 `show_str` 改为了 `print`，注意区分。
