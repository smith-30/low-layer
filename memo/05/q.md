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

### 連結リストとは

linked-list

自分の前後といったメタ情報を持ったリスト

### コンパイルの段階には何があるか

プリプロセッサによって変数などが文字列置換されたソースコード

### 前処理とは

ある文字列を別の文字列で変換する

### マクロの実体化とは

例えば、

```
%define hoge 666

mov rax hoge
```

としたときにhogeを666で置き換えること

### なぜマクロの内側に%%演算子が必要なのか

マクロ内部でローカルラベルを使うため

### NASMのマクロプロセッサがサポートする条件に何があるか、どのディレクティブを使うか

`%define` で既存のプリプロセッサシンボルを再定義することができる

### ELFオブジェクトの3つの種類とは

- 再配置可能 relocatable
- 実行可能 executable
- 共有 shared

### ELF ファイルにはどんなヘッダがあるのか

リスト5-21参照、省略

### ELFファイルの中に入る可能性のあるセクションは何か

