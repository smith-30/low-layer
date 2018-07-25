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
    mov rdx, rax ; set string len
    mov rax, 1
    mov rdi, 1
    syscall
    ret


print_char:
    push rdi
    mov rdi, rsp      ; why stack pointer? -> 退避
    call print_string
    pop rdi
    ret


print_newline:
   mov rdi, 10
   jmp print_char

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
    or dl, 0x30
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .loop

    call print_string

    add rsp, 24
    ret 
   

print_int:
    test rdi, rdi
    jns print_uint
    push rdi
    mov rdi, '-'
    call print_char
    pop rdi
    neg rdi
    jmp print_uint