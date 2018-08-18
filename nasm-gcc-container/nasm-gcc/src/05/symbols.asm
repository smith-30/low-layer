section .data
datavar1: dq 1488
datavar2: dq 42

section .bss
bssvar1: resq 4*1024*1024
bssvar2: resq 1

section .text

# 他のモジュールで定義され、現在のモジュールが参照するシンボル
extern somewhere
# 他のモジュールからもexternをつければ参照できる
global _start
    mov rax, datavar1
    mov rax, bssvar1
    mov rax, bssvar2
    mov rax, datavar2

_start:
    jmp _start
    ret

textlabel: dq 0

# dump 結果
; $ nasm -f elf64 symbols.asm && objdump -tf -m intel symbols.o

; symbols.o:     file format elf64-x86-64
; architecture: i386:x86-64, flags 0x00000011:
; HAS_RELOC, HAS_SYMS
; start address 0x0000000000000000

; SYMBOL TABLE:
; 0000000000000000 l    df *ABS*	0000000000000000 symbols.asm
; 0000000000000000 l    d  .data	0000000000000000 .data
; 0000000000000000 l    d  .bss	0000000000000000 .bss
; 0000000000000000 l    d  .text	0000000000000000 .text
; 0000000000000000 l       .data	0000000000000000 datavar1
; 0000000000000008 l       .data	0000000000000000 datavar2
; 0000000000000000 l       .bss	0000000000000000 bssvar1
; 0000000002000000 l       .bss	0000000000000000 bssvar2
; 000000000000002b l       .text	0000000000000000 textlabel
; 0000000000000000         *UND*	0000000000000000 somewhere
; 0000000000000028 g       .text	0000000000000000 _start

# Todo シンボルの仮想アドレスのオフセットの追い方

# 2列目、1: ローカル, g: グローバル, ブランクはどちらでもない

