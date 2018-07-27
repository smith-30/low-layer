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

@Todo
関数コールで暗黙的に引数としてとられるので
関数側で触りにいく

### ハードウェアスタックの使い方は? 利用できる命令は?

関数などで使用され、意図しないレジスタの書き換えを防ぐために
値のキャッシュ場所として使える
利用できるのはハードウェアスタックに書き込むpush
取り出すpop

### 次にあげる命令のうち、正しくないのはどれか、理由は

- mov [rax], 0 # raxメモリの初期化 -> ○
- cmp [rdx], bl ; rbxの下位バイト -> ○
- mov bh, bl -> ○
- mov al, al -> 意味ないから☓?
- add bpl, 9 -> スタックフレームのポインタなのでいじるべきではない - ☓?
- add [9], spl -> 9のアドレスのメモリ内容が書き換わるだけなので○?
- mov r8d, r9d -> 問題ない
- mov r3b, al -> ○
- mov r9w, r2d -> 下位2バイトに下位3バイトはオーバーフロー?するので☓
- mov rcx, [rax + rbx + rdx] ○
- mov r9, [r9 + 8*rax] ○
- mov [r8+r7+10], 6 ○
- mov [r8+r7+10], r6 ○