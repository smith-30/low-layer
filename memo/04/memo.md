## 仮想メモリ

### 機能

1プロセスのアドレス空間はページ(通常4KB)に分割されている

- 複数のプロセスで一部のページを共有できる
- 外部デバイスとの通信をMemory Mapped I/Oで行う
    - 何らかのデバイスのポートに割り当てたアドレスに書いたりそこから読むことができる
- OSとファイルシステムと連携して外部ストレージのファイルに一部のページを対応させることができる

### なぜ物理メモリの上に仮想メモリを置くのか

仮想メモリを置くことで解決できる課題
- 同一データあるいはコードを複数プログラムから扱う際に個々にメモリ内に複製するムダ
- 任意のサイズのプログラム(たぶん物理メモリより大きくても)を実行したい
    - プログラムのうち、すぐ必要になる部分だけをロードする能力が必要
- いくつものプログラムをメモリに置きたい
- 

#### CPUチップ

- CPU データキャッシュ
    - LI
    - L2
    - L3
    - 命令キャッシュ
        - 命令のキューを格納
    - TLB   Translation Lookaside Buffer
        - 仮想メモリの性能を向上させる

もっともCPUに近いレベルのものはほとんどレジスタに迫るよう

データキャッシュ容量 > レジスタ


### アドレス空間

仮想アドレス = 論理アドレス

仮想アドレスと物理アドレスのプロキシが
**MMU** Memory Management Unit

仮想メモリはアプリケーションと物理メモリとのプロキシ


### メモリマップ

どのページが利用可能で、何に対応するか示すもの

- メモリ領域の種類
    - メモリにロードされた「実行ファイル」自身に相当するもの
    - コードのライブラリに対応するもの
    - スタックとヒープに対応する「名前のないページ」
    - 無効なアドレスばかりの、空の領域

プロセスのファイル情報は/procにマウントされている

`<PID>`のプロセスのメモリマップは
`/proc/<PID>/maps`というファイル

ページが 4KB(0x1000)サイズなので マップの下位3桁は
xxxxxx000 - xxxxx000 の範囲になる

### 仮想アドレスの構造

アドレスそのものは48bit
符号拡張されて64bitになっている
そのため、上位17bitは全て同じ

下位12bit(=4kb)はページ先頭からのオフセットを表す
てことはbyte単位でアクセスか。12bit=4096 * 1byte = 4kb
なぜなら、物理アドレス空間は仮想ページを当てる複数のスロットに分割されているが
スロット間に隙間はないので上記のようになっている

http://www.coins.tsukuba.ac.jp/~yas/coins/os2-2011/2012-01-24/

linuxは4層のアドレス空間で構成

制御レジスタcr3から最初のテーブルの開始アドレスを取る
あとは上位bitを順に読んで物理メモリまでたどり着く
物理メモリでは12bitのオフセット

ページテーブルエントリ(物理メモリの手前)のW bitが立っていると
コードまたはプロセス間でデータを共有できる
U bitはシステム用のページ
P bitは物理メモリに存在するかのフラグ

**セグメントの保護がないとき、仮想メモリが決定的なメモリ保護機構**


### メモリマッピング

物理メモリと仮想メモリとのマッピングを決定
メモリマッピングにはシステムコールの `mmap` が使われる

というか物理メモリってデータ保存領域とデータ保存先(アドレス)を提供する
key-value的なハード