global _start

section .data

test_string: db "abcdef", 0 ; 文字列の終わりを示す. 0を使ったものは
                            ; null-terminated string と呼ばれる
section .text

strlen:                 ; この関数はただ1個の引数をrdiから受け取る
                        ; (われわれの規約による)
    xor rax, rax        ; raxに文字列の長さが入る。最初にゼロで初期化
                        ; しなければランダムな値になってしまう

.loop:                      ; start main loop
    cmp byte [rdi+rax], 0   ; 現在の文字/記号が終結のヌルかどうかを調べる
                            ; ここで `byte` 修飾が絶対に必要
                            ; (cmpのオペランドは左右必ず同じサイズ)
                            ; 右側のオペランドがイミディエイトでサイズの情報がないので、
                            ; メモリから何バイト取り出してゼロと比較すればよいのか
                            ; `byte` がなければ不明である

    je .end ; if find null jump

    inc rax ; else jump next string (count up)

    jmp .loop

.end:
    ret ; `ret` に到着したとき、raxに戻り値が入っている

_start:
    mov rdi, test_string
    call strlen
    mov rdi, rax
    mov rax, 60
    syscall