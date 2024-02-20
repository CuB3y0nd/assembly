# pwndbg cheat sheet

## 设置调试环境

设置调试目标的架构。

```bash
set architecture <arch>

alias: set processor <arch>
```

显示当前调试目标的架构。

```bash
show architecture
```

## 远程调试

```bash
target remote <remote_address>
```

## 反汇编

```bash
disassemble

alias: disass
```

## 寄存器

 - `i r`：查看所有寄存器
 - `i <register_name>`：查看指定寄存器

## 执行指令

 - `s`：单步步入，遇到调用跟进函数中(step into)，源码层的一步
    - `si`：同 `s`，汇编层的一步
 - `n`：单步步过，遇到函数不跟进(step over)，源码层的一步
    - `ni`：同 `n`，汇编层的一步
 - `c`：继续执行到断点，没断点就一直执行下去
 - `r`：重新开始执行整个程序
 - `start`：类似于 `r`，停在 `main` 函数

## 断点

 - `b *<address>`：在指定地址处下断点
 - `i b`：查看所有断点的信息
 - `del [break_number]`：删除指定序号的断点。**直接使用 `del` 会删除所有断点**
 - `i f`：查看所有函数的信息
 - `b <function_name>`：在指定函数的位置下断点
 - `enable <break_number>`：启用指定的断点
 - `disable <break_number>`：禁用指定的断点
 - `clear`：清除下面的所有断点

## 内存

指令格式为：

```bash
x/nfu <address>
```

 - `n`：输出单元的个数（不是字节）
 - `f`：输出格式
    - `d` 十进制
    - `t` 二进制
    - `x` 十六进制
    - `o` 八进制
    - `u` 无符号十进制
    - `a` 地址
    - `c` 字符
    - `s` 字符串
    - `f` 浮点数
    - `i` 指令
 - `u`：一个单位的长度
    - `b` $\text{1 Byte}$
    - `h` $\text{2 Bytes(WORD)}$
    - `w` $\text{4 Bytes(DWORD)}$
    - `g` $\text{8 Bytes(QWORD)}$

## 打印指令

 - `p <function_name>` 打印指定函数的地址
 - `p 0x10-0x08` 计算 `0x10-0x08` 的值
 - `p &<var>` 查看指定变量的地址
 - `p *(0x123456)` 查看 `0x123456` 地址处的值
 - `p $<register>` 显示指定寄存器的值。注意和 `x` 的区别，它只是显示寄存器的值，而不是寄存器指向的值
 - `p *($<register>)` 显示指定寄存器指向的值

## De Bruijn 序列

 - `cyclic <length>`：生成指定长度的序列
 - `cyclic -l <lookup_value>`：计算偏移量

## layout 小窗

```bash
layout <layout_type>
```

**layout_types**

 - `asm`：显示汇编窗口
 - `src`：显示源代码窗口
 - `regs`：显示源代码、汇编和寄存器窗口
 - `split`：显示源代码和汇编窗口
 - `next`：显示下一个 layout
 - `prev`：显示上一个 layout

### layout 快捷键

 - `Ctrl+L` 刷新窗口
 - `Ctrl+X+1` 单窗口模式
 - `Ctrl+X+2` 双窗口模式
 - `Ctrl+X+A` 传统模式

## 退出

```bash
q
```

