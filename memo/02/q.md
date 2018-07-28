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

同じレジスタの異なるパーツの名称

eax は raxの下位4バイト
axはraxの下位2バイト
alはraxの最下位バイト
ahはaxの上位バイト

raxだけ最下位ワードの上位バイトにアクセスできる(ah)

### r9レジスタの一部にアクセスするにはどうすればよいか

@Todo
~~関数コールで暗黙的に引数としてとられるので関数側で触りにいく~~

`一部`というのがポイント

32bit: r9d 
16bit: r9w
8bit: r9b


### ハードウェアスタックの使い方は? 利用できる命令は?

関数などで使用され、意図しないレジスタの書き換えを防ぐために
値のキャッシュ場所として使える
利用できるのはハードウェアスタックに書き込むpush
取り出すpop

call, ret

### 次にあげる命令のうち、正しくないのはどれか、理由は

- mov [rax], 0 ~~# raxメモリの初期化 -> ○~~
    - メモリには8, 4, 2, 1byteのコピーをさせるため☓
- cmp [rdx], bl ; rbxの下位バイト -> ○
- mov bh, bl -> ○
- mov al, al -> 意味ないから☓?
- add bpl, 9 -> スタックフレームのポインタなのでいじるべきではない - ☓?
- add [9], spl -> 9のアドレスのメモリ内容が書き換わるだけなので○?
- mov r8d, r9d -> 問題ない
- mov r3b, al ~~-> ○~~
    - nasm does not support r0-r7 names, only r8 - r15
- mov r9w, r2d ~~-> 下位2バイトに下位3バイトはオーバーフロー?するので☓~~
    - nasm does not support r0-r7 names, only r8 - r15
- mov rcx, [rax + rbx + rdx] ○
- mov r9, [r9 + 8*rax] ○
- mov [r8+r7+10], 6 
    - nasm does not support r0-r7 names, only r8 - r15
- mov [r8+r7+10], r6 
    - nasm does not support r0-r7 names, only r8 - r15

### 呼び出し先退避レジスタ

p33

rbx, rbp, rsp, r12-15

### 呼び出し元退避レジスタ

呼び出し前に退避、呼び出し後に復旧

上記7個以外

### ripレジスタの意味

rip is Instruction Pointer Register

ripには次に実行すべき命令のアドレスが格納される
プログラマがアクセス可能

### what is SF flag

算術命令で結果がマイナス値だったときにセットされる

### what is ZF flag

算術命令をしたときに結果が0だったときにセット

### explain under each operation

- sar
    - 左ビットシフト
- shr
    - 右ビットシフト
- xor
    - 排他的論理和
- jmp
    - 定義したラベルへジャンプさせる
- ja, jb, その他
    - jump if above
    - jump if below
    - jg 
        - jump if greater
    - jl 
        - jump if less
    - jae 
        - jump if above or equal
    - jle 
        - jump if less or equal
- cmp
    - オペランド比較, compare
- mov
    - データ転送
- inc, dec
    - 加算, 減算
- add
    - 足し算
- imul, mul
    - 符号なしかけ算
    - かけ算
- sub
    - 引き算
- idiv, div
    - 符号なし割り算
    - 割り算
- call, ret
    - プロシージャ呼び出し
    - 復帰
- push, pop
    - push: push stack
    - pop: pop from stack
- neg
    - 符号の反転

### ラベルとは何か、サイズはあるのか

処理のスコープを表す
プログラム全体に定義できるグローバルラベル
.から始まるローカルラベルがある

ラベルはアドレスの名前を指す
ラベル自体はメモリに保存されないためサイズは持たない

### ある整数値が、ある範囲(x, y)に含まれるかどうかをどうすればチェックできるか

```asm
mov rax, 20

cmp rax, 42
jg _no
cmp rax, 13
jl _no

_yes:
13 <= rax <= 42>

_no:
;42 < rax
;rax < 13

```

### rax がゼロかどうかを、cmpコマンドを使わずにテストする方法は

```
test rax, rax
jz _label

_label:
; we jump to here if rax == 0 
```

### プログラムのリターンコードとは何か

実行結果を返す
正常終了の場合は`0`
その他はerror code を返す

アセンブリではexitにediを渡す

### ただ１つの命令で、raxを9倍にする方法は

lea rax, [rax*9]

@Todo why
-> lea rax, [rax + rax*8]

### ただ2つの命令で(最初の命令はneg)、raxに格納されている整数の絶対値を求めよ

```
label:
neg rax
jl label
; here rax holds its absolute value
```

@Todo why jl label. 無限ループしそうな気がするんだけど
あくまで`label`は例で他のラベルに飛ばせばいいのかな


### リトルエンディアンとビッグエンディアンはどう違うのか

複数バイトの先頭をメモリの最下位バイトから置いていくのがリトルエンディアン
ビッグエンディアンはその逆

### もっとも複雑な種類のアドレッシングは

`base + scale + offset + displacement`

displacement should be an immediate value
scale should be equal to 1, 2, 4, o 8r

### プログラムの実行はどこからはじまるか

~~プログラムが格納されているメモリアドレスの最下位バイトから~~

_startラベルから

### raxの値が 0x1122334455667788 のとき <br> push raxを実行した。[rsp+3]のアドレスにあるバイトデータの内容は?

intel64はLE
メモリのインデックスは0からなので注意

rsp+0 - 0x88
rsp+1 - 0x77
rsp+2 - 0x66

Ans. 0x55