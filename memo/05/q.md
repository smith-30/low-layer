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

- .text
    - マシン語命令
- .rodata
    - read only data
- .data
    - 初期化されたグローバル変数
- .bss
    - 読み書き可能なグローバル変数が `ゼロ` で初期化される

その他にもあるがよく使われるものは上記

### シンボルテーブルとは何か、どのような情報が入るのか

シンボルのメタ情報を持つもの
仮想アドレスや仮想アドレスやシンボルの属性(ローカル/グローバル)
シンボル名などをもつ

### セクションとセグメントには関連があるのだろうか

リンカからみたELFビューはセクションで構成され
ローダから見たELFビューはセグメントで構成される

セクションをメモリにマッピングしたのがセグメント

### アセンブリのセクションとELFのセクションは関連があるか

NASMのセクションはオブジェクトファイルのセクションに対応する

### プログラムのエントリポイントをマークするシンボルはなにか

`_start`

### ライブラリの2つの種類とは

- 動的ライブラリ
    - 必要なときにロードされる
- 静的ライブラリ
    - 再配置可能なオブジェクトファイルで構成される -> プログラムの各部に決定的なアドレスを割り当て
    すべてのリンクが適切に解決するようプログラムのコードを変更したあとのもの
    メインプログラムにリンクされ、実行ファイルに組み込まれる
    なので、更新の際にはビルドが必要

### 静的ライブラリと再配置可能なオブジェクトファイルとの間の違い

↑ で記述
