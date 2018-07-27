### xor rdi, rdi

rdiレジスタに rdiとrdiをxorした結果を入れる
mov rdi, 1
xor rdi, rdi
は 1, 1なので0が入る

mov rdi, 0より実行効率がいいらしい

### リターンコード

0

### exit システムコールの第一引数

rdiはsyscall実行時に値が第一引数として参照される模様
rdi, rsi, rdx, ...
0

### ascii　コードチェック

```
$ man ascii
```

### difference between sar and shr

- sar Shift arithmetic right.(算術シフト)
    - 符号ビットを除いてシフトするもので、空いたビット位置すべてに左シフトの時は０、**右シフトの時は符号ビットと同じものが入る**

- shr Shift logical right.(論理シフト)
    - 符号ビット（先頭ビット，第１５ビット，最も左のビット）を含めてシフトするもので、空いたビット位置すべてに０が入る

![image](./arithRight.gif)

intel's volume 1, 5.1.5

### 数を10進`以外`の方法でnasmが理解できるように書くにはどうするか

https://www.nasm.us/doc/nasmdoc3.html#section-3.4.1
参照

### je, jz

- je
    - jump if equal

- jz 
    - jump if zero

### list of each test

Todo

```
section .data
test: dq -1

section .text
    mov byte[test], 1
    ; 01 FF FF FF FF FF FF FF 

    mov word[test], 1
    ; 01 00 FF FF FF FF FF FF 

    mov dword[test], 1
    ; 01 00 00 00 FF FF FF FF

    mov qword[test], 1
    ; 01 00 00 00 00 00 00 00
```

### Todo

- q_20
- q_21
- q_22

### rax, eax, ax, ah, al のレジスタにはどういう関係があるか

eax は raxの下位4バイト
axはraxの下位2バイト
alはraxの最下位バイト
ahはaxの上位バイト

raxだけ最下位ワードの上位バイトにアクセスできる(ah)

### r9レジスタの一部にアクセスするにはどうすればよいか