global _start

section .data
message: db 'hello, world!', 10

section .text
_start:
    mov rax, 1 ; システムコールの番号をraxに入れる(write)
    mov rdi, 1 ; 引数 #1 は rdi: 書き込み先(descripter) -> stdout
    mov rsi, message ; 引数 #2 は rsi: 文字列の先頭
    mov rdx, 14 ; 引数 #3 は rdx: 書き込むバイト数
    syscall ; システムコールの呼び出し

    mov rax, 60 ; exitのsyscall
    xor rdi, rdi
    syscall