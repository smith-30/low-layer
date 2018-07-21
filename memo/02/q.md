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