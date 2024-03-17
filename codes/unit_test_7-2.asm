jmp near start

positive_text db 'P', 0x07, 'o', 0x07, 's', 0x07, 'i', 0x07, 't', 0x07, 'i', 0x07, 'v', 0x07, 'e', 0x07, ':', 0x07, ' ', 0x07
positive_text_end db 0
negative_text db 'N', 0x07, 'e', 0x07, 'g', 0x07, 'a', 0x07, 't', 0x07, 'i', 0x07, 'v', 0x07, 'e', 0x07, ':', 0x07, ' ', 0x07
negative_text_end db 1

data1 db 0x05, 0xff, 0x80, 0xf0, 0x97, 0x30
data1_end db 0
data2 dw 0x90, 0xfff0, 0xa0, 0x1235, 0x2f, 0xc0, 0xc5bc
data2_end db 0

start:
  ; 设置数据段基地址
  mov ax, 0x7c0
  mov ds, ax

  ; 设置附加段基地址
  mov ax, 0xb800
  mov es, ax

  ; 输出 `Positive: `
  cld
  mov si, positive_text
  mov di, 0
  mov cx, (positive_text_end - positive_text) / 2
  rep movsw

  ; 输出 `Negative: `
  cld
  mov si, negative_text
  mov di, 160
  mov cx, (negative_text_end - negative_text) / 2
  rep movsw

  ; AH 存放正数的个数
  ; AL 存放负数的个数
  xor ax, ax

  ; 设置 data1 中数据的基地址
  mov bx, data1
  mov si, 0

  ; 设置循环次数
  mov cx, data1_end - data1

  ; 清空 DX 寄存器
  xor dx, dx

; 判断 data1 中数的正负
data1cmp:
  mov dl, [bx+si]
  test dl, dl
  js data1negative
  inc ah
  inc si
  loop data1cmp
  jmp data1over

; 若为负数
data1negative:
  inc al
  inc si
  loop data1cmp

; data1 判断结束，data2 开始
data1over:
  mov bx, data2
  mov si, 0
  mov cx, (data2_end - data2) / 2
  xor dx, dx

data2cmp:
  mov dx, [bx + si]
  test dx, dx
  js data2negative
  inc ah
  times 2 inc si
  loop data2cmp
  jmp show

data2negative:
  inc al
  times 2 inc si
  loop data2cmp

; 输出结果
show:
  ; 转换为十进制 ASCII
  add ax, 0x3030
  mov [es:di - 160], ah
  mov [es:di], al

jmp near $

times 510-($-$$) db 0
db 0x55, 0xaa

