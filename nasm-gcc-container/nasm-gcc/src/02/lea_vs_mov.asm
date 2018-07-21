; rsi <- ラベル `codes` のアドレス (数値)
mov rsi, codes ; rsi -> ストリング操作コマンド (例えばmovsd)のソース側インデックス


; rsi <- `codes` というアドレスから始まるメモリの内容
; rsi は8バイト長なので、連続する8バイトが得られる
mov rsi, [codes]

; rsi <- address of `codes` のアドレス
; この場合は、mov, rsi, codesと等しいが
; アドレスは複数の部分を含むことができる
lea rsi, [codes]

; rsi <- (codes + rax)から始まるメモリの内容
mov rsi, [codes + rax]

; rsi <- codes + rax
; これは次の2つを組み合わせたものに等しい
; -- mov rsi, codes
; -- add rsi, rax
; 一回のmovでこれはできない!
lea rsi, [codes + rax]

