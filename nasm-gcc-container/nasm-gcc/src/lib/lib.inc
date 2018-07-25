section .text

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

string_length:
    xor rax, rax
.loop:                      
    cmp byte [rdi+rax], 0
    je .end
    inc rax ; else jump next string (count up)
    jmp .loop
.end:
    ret ; `ret` に到着したとき、raxに戻り値が入っている

print_string:
    push rdi
    call string_length
    pop rsi ; Todo why pop rsi? get first buffer address
            ; write 用に戻している?
            ; 書き込むバイトシーケンスの先頭バイトが使われる、rsiは勝手にどこかでstackされている?
            ; なるほど、stackに詰められているアドレスをそのまま受け取ってるのか
            ; なので、print_newlineから見れば、10をスタックに置いたときのアドレスが入っている
    mov rdx, rax ; set string len
    mov rax, 1
    mov rdi, 1
    syscall
    ret


print_char:
    push rdi
    mov rdi, rsp      ; why stack pointer? -> 退避させた後そのアドレスをすぐに突っ込んでいる
    call print_string
    pop rdi
    ret

print_newline:
   mov rdi, 10
   jmp print_char


; 8バイト長の符号なし整数を10進フォーマットで出力する
; スタック上にバッファを作成し、そこに除算の結果を格納する
; 実際にはrspからバッファサイズを引くことでスタックにメモリを割り当てる
; 剰余を10で割り、その商に対応する10進桁数をバッファ内にいれる。
; それぞれの桁数をASCIIコードに変換することを忘れないように(0x04 -> 0x34)

; Todo why trans ascii?
; 8バイト長の崩し方というかそこら辺理解してない
; rspの使い方もわかんないし
print_uint:
    mov rax, rdi
    mov rdi, rsp
    push 0
    sub rsp, 16

    dec rdi
    mov r8, 10

.loop:
    xor rdx, rdx
    div r8
    or dl, 0x30 ; 0?
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .loop

    call print_string

    add rsp, 24
    ret 
   
; 符号付き8バイト長の整数を10進フォーマットで出力する
print_int:
    test rdi, rdi
    jns print_uint
    push rdi
    mov rdi, '-' ; print `-` for -100
    call print_char
    pop rdi
    neg rdi ; 符号の反転
    jmp print_uint