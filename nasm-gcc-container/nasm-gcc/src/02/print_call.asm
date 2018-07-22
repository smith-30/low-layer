section .data

newline_char: db 10
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
    mov rax, 1 ; write システムコールのID
    mov rdi, 1 ; stdout ファイルのディスクリプタ
    mov rsi, newline_char ; 書き込むデータの場所
    mov rdx, 1 ; 書き込むバイト数
    syscall
    ret

print_hex:
    mov rax, rdi
    mov rdi, 1
    mov rdx, 1
    mov rcx, 64 ; rax レジスタをシフトするビット数
iterate:
    push rax ; raxの値を退避
    sub rcx, 4 ; rcx: 60, 56, 52, ... 4, 0
    sar rax, cl ; raxをclビットだけ右に回転シフト
                ; (cl レジスタは rcxの最下位バイト)

    and rax, 0xf ; 下位4ビット以外の値をクリア
    ; Todo
    ; 繰り返しで入ってくる値はアセンブリがよしなにシフト?してくれる?
    lea rsi, [codes + rax] ; 16 進数の文字コードを取得

    mov rax, 1 ; write

    push rcx ; syscallはrcxを壊す
    ; システムコールの引数は関数とは異なるレジスタ集合に格納する
    ; 関数コールでは第4引数をrcxに入れるが
    ; システムコールでは第4の引数をr10に入れる!
    ; なぜならsyscall命令が暗黙のうちにrcxを使うから

    syscall ; rax = 1 -- `write` の ID
            ; rdi = 1 (stdout)
            ; rsi = 文字コードのアドレス

    pop rcx
    pop rax ; raxの値を復旧
    test rcx, rcx ; rcx = 0なら全部の桁を表示した
    jnz iterate

    ret

_start:
    mov rdi, 0x1122334455667788
    call print_hex
    call print_newline

    mov rax, 60
    xor rdi, rdi
    syscall