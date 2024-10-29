## 检测点 9.1

```
（1）程序如下。

assume cs:code

data segment
  ?
dadta ends

code segment
  start: mov ax, data
         mov ds, ax
         mov bx, 0h
         jmp word ptr [bx + 1h]
code ends

end start

若要使程序中的 jmp 指令执行后，CS:IP 指向程序的第一条指令，在 data 段中应该定义哪些数据？
```

```asm
assume cs:code

data segment
  db 3h dup (0h)
dadta ends

code segment
  start: mov ax, data
         mov ds, ax
         mov bx, 0h
         jmp word ptr [bx + 1h]
code ends

end start
```

```
（2）程序如下。

assume cs:code

data segment
  dd 12345678h
data ends

code segment
  start: mov ax, data
         mov ds, ax
         mov bx, 0h
         mov [bx], ____
         mov [bx + 2h], ____
         jmp dword ptr ds:[0h]
code ends

end start

补全程序，使 jmp 指令执行后，CS:IP 指向程序的第一条指令。
```

```asm
assume cs:code

data segment
  dd 12345678h
data ends

code segment
  start: mov ax, data
         mov ds, ax
         mov bx, 0h
         mov [bx], bx
         mov [bx + 2h], cs
         jmp dword ptr ds:[0h]
code ends

end start
```

```
（3）用 Debug 查看内存，结果如下：

2000:1000 BE 00 06 00 00 00 ......

则此时，CPU 执行指令：

mov ax, 2000h
mov es, ax
jmp dword ptr es:[1000h]

后，(CS)=？，(IP)=？
```

- (CS)=0006h, (IP)=00BEh

## 检测点 9.2

```
补全程序，利用 jcxz 指令，实现在内存 2000H 段中查找第一个值为 0 的字节，找到后，将它的偏移地址存储在 dx 中。

assume cs:code

code segment
  start:  mov ax, 2000h
          mov ds, ax
          mov bx, 0
      s:  ________
          ________
          ________
          ________
          jmp short s
      ok: mov dx, bx
          mov ax, 4c00h
          int 21h
code ends

end start
```

```asm
assume cs:code

code segment
  start:  mov ax, 2000h
          mov ds, ax
          mov bx, 0
      s:  mov ch, 0h
          mov cl, [bx]
          jcxz ok
          inc bx
          jmp short s
      ok: mov dx, bx
          mov ax, 4c00h
          int 21h
code ends

end start
```

## 检测点 9.3

```
补全程序，利用 loop 指令，实现在内存 2000H 段中查找第一个值为 0 的字节，找到后，将它的偏移地址存储在 dx 中。

assume cs:code

code segment
  start:  mov ax, 2000h
          mov ds, ax
          mov bx, 0
      s:  mov cl, [bx]
          mov ch, 0h
          ________
          inc bx
          loop s
     ok:  dec bx
          mov dx, bx
          mov ax, 4c00h
          int 21h
code ends

end start
```

```asm
assume cs:code

code segment
  start:  mov ax, 2000h
          mov ds, ax
          mov bx, 0
      s:  mov cl, [bx]
          mov ch, 0h
          inc cx
          inc bx
          loop s
     ok:  dec bx
          mov dx, bx
          mov ax, 4c00h
          int 21h
code ends

end start
```

## 实验 8：分析一个奇怪的程序

略

## 实验 9：根据材料编程

[源码](../codes/lab_9.asm)
