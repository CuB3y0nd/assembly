# assembly.rip

李忠《x86 汇编语言：从实模式到保护模式》（第二版）检测点及章节习题

## 目录

- [第 1 章](ch01/README.md)
    - [检测点 1.1](ch01/README.md#检测点-11)
    - [检测点 1.2](ch01/README.md#检测点-12)
    - [检测点 1.3](ch01/README.md#检测点-13)
    - [检测点 1.4](ch01/README.md#检测点-14)
    - [检测点 1.5](ch01/README.md#检测点-15)
    - [检测点 1.6](ch01/README.md#检测点-16)
    - [第 1 章习题](ch01/README.md#第-1-章习题)
- [第 2 章](ch02/README.md)
    - [第 2 章习题](ch02/README.md#第-2-章习题)
- [第 3 章](ch03/README.md)
    - [检测点 3.1](ch03/README.md#检测点-31)
    - [检测点 3.2](ch03/README.md#检测点-32)
    - [检测点 3.3](ch03/README.md#检测点-33)
    - [第 3 章习题](ch03/README.md#第-3-章习题)
- [第 4 章](ch04/README.md)
    - [检测点 4.1](ch04/README.md#检测点-41)
    - [第 4 章习题](ch04/README.md#第-4-章习题)
- [第 5 章](ch05/README.md)
    - [检测点 5.1](ch05/README.md#检测点-51)
    - [检测点 5.2](ch05/README.md#检测点-52)
- [第 6 章](ch06/README.md)
    - [检测点 6.1](ch06/README.md#检测点-61)
    - [检测点 6.2](ch06/README.md#检测点-62)
    - [检测点 6.3](ch06/README.md#检测点-63)
    - [检测点 6.4](ch06/README.md#检测点-64)
    - [检测点 6.5](ch06/README.md#检测点-65)
    - [第 6 章习题](ch06/README.md#第-6-章习题)

## pwndbg cheat sheet

这份 [Cheat Sheet](misc/pwndbg-cheat-sheet.md) 记录了一些常用的 pwndbg 调试指令，方便查阅。

## 使用 Qemu + GDB 调试汇编程序

使用以下指令即可启动虚拟机：

```shell
qemu-system-i386 -s -S -drive format=raw,file=<binary_file> --nographic
```

 - ***<binary_file> 替换为你编译出来的二进制文件名***

运行虚拟机后在新的终端打开 `gdb`，输入以下指令即可连接虚拟机远程调试：

```bash
set architecture i8086
target remote localhost:1234
```

使用 `layout asm` 可以查看接下来要运行的指令，十分方便。若要切换它的显示状态可以使用 `Ctrl + X + A`。

更多用法可以参考我的 [pwndbg cheat sheet](https://github.com/CuB3y0nd/assembly.rip/blob/master/misc/pwndbg-cheat-sheet.md#layout-%E5%B0%8F%E7%AA%97)。

## License

[assembly.rip](https://github.com/CuB3y0nd/assembly.rip) © 2024 by [CuB3y0nd](https://www.cubeyond.net) is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0).

