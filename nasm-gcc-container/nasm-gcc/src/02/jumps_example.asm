    cmp rax, 42

    ; jg (jump if greater), jl (jump if less) は符号付きの比較に用いる
    jl yes
    mov rbx, 0
    kmp ex
yes:
    mov rbx, 1
ex: