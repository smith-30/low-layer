%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
; ファイル名
fname: db 'test.txt', 0

section .text
global _start

print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall
    ret

string_length:
    xor rax, rax
.loop:
    cmp byte [rdi+rax], 0
    je .end
    inc rax
    jmp .loop
.end:
    ret

_start:
; call open
mov rax, 2
mov rdi, fname
mov rsi, O_RDONLY   ; read only でファイルをopen
mov rdx, 0          ; create ではないので、この引数は無意味
syscall
; call mmap
mov r8, rax     ; rax は openしたファイルのディスクリプタ
                ; それをmmapの第四引数とする
mov rax, 9      ; mmapのシステムコール番号
mov rdi, 0      ; マップ先はOSが選ぶ
mov rsi, 4096   ; ページサイズ
mov rdx, PROT_READ ; 新しいメモリ領域は read onlyとマークされる
mov r10, MAP_PRIVATE ; ページの共有なし

mov r9, 0
syscall

mov rdi, rax
call print_string

mov rax, 60 ; exitで終了
xor rdi, rdi
syscall