section .data
test: dq -1

section .text
    mov byte[test], 1
    mov word[test], 1
    mov dword[test], 1
    mov qword[test], 1

global _start

_start:
    ; mov byte[test], 1
    ; mov word[test], 1
    ; mov dword[test], 1
    ; mov qword[test], 1

    mov rax, 1
    mov rdi, 1 
    mov rsi, [test] 
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

    ; mov word[test], 1
    ; mov dword[test], 1
    ; mov qword[test], 1