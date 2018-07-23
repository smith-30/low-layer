global _start

section .data
test_string: db "abcdef", 0

section .text

strlen:
    push r13 ; 呼び出し先退避レジスタ(関数内で変更する場合、関数内で元に戻す)
.loop:
    cmp byte [rdi+r13], 0
    je .end
    inc r13
    jmp .loop
.end:
    mov rax, r13
    pop r13 ; 呼び出し先退避レジスタ
    ret

_start:
    mov rdi, test_string
    call strlen
    mov rdi, rax
    mov rax, 60
    syscall