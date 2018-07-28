    lgdt cs:[_gdtr]

    mov eax, cr0 ; 特権命令
    or al, 1     ; このbitがprotected modeに対応する
    mov cr0, eax ; !! 特権命令

    jmp (0x1 << 3): start32 ; 最初のセグメントセレクタをcsに割り当てる
                            ; start32 は 32bitのスタートコード


; アラインメントを制御する
align 16
_gdtr:
dw 47       ; GDTの最終エントリのインデックス
dq _gdt    ; GDTのアドレス

align 16

_gdt:
; null descriptor
dd 0x00, 0x00

; x32 コードディスクリプタ
db 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x9A, 0xCF, 0x00   ; exec bit が on (0x9A)

; x32 データディスクリプタ
db 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x92, 0xCF, 0x00   ; exec bit が off (0x92)
; size size base base base util util|size base

 