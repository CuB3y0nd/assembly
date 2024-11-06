## 检测点 14.1

```
（1）编程，读取 CMOS RAM 的 2 号单元的内容。
```

```asm
mov al, 2h
out 70h, al
in al, 71h
```

```
（2）编程，向 CMOS RAM 的 2 号单元写入 0。
```

```asm
mov al, 2h
out 70h, al
mov al, 0h
out 71h, al
```
