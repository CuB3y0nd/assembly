## 检测点 8.1

```
以下指令执行后，寄存器 AX 中的内容是多少？

mov ax, 0xfff0
and [data], ax
or ax, [data]
data 0x55, 0xaa
```

- $\text{AX: 0xfff0}$

```
下面的说法中哪些是正确的？

A. 8086 处理器执行压栈操作时，是先将 SP 的内容减 2，再访问栈段。
B. 8086 处理器执行出栈操作时，是先将 SP 的内容加 2，再访问栈段。
C. 如果 SP 的内容为 0xFFFC，则执行 push ax 后，SP 的内容变为 0xFFFA。
```

- $\text{A、C}$
