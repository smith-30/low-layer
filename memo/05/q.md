### %defineと%macroのその他例

マクロ内で他のマクロを呼ぶこともできる

```
%define a(x) 1+b(x)
%define b(x) 2*x

mov ax, a(8)
```

複数引数渡して、変数宣言したり

```
%macro  silly 2 

    %2: db      %1 

%endmacro 

        silly 'a', letter_a             ; letter_a:  db 'a' 
        silly 'ab', string_ab           ; string_ab: db 'ab' 
        silly {13,10}, crlf             ; crlf:      db 13,10
```