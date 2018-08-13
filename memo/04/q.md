### その他ページ置換法


### man procfs

- 経過時間
- プロセス番号

プロセスがshared(s), private(p)かもメモリマップみればわかる

### associative cache

連想キャッシュ
tagによってメインメモリとキャッシュメモリを紐付ける
そのため、メインメモリは複数のキャッシュを参照できる
2-way associative cache
4-way associatibe cache
など

Todo
アドレスリクエストはTagとWordを足したもので行われる?
22bit Tag
2bit Word
↓ら辺見た限り

https://www.slideshare.net/Sajith3D2010/memory-mapping-cache

![image](./associative.png)

これがわかりやすいな
2-way 2つのセットのうち
どれかを指定して、さらにTagが等しければ
Hit って感じかな
![image](./2-way-set-associative-cache.png)
OffsetはTodo

### 仮想メモリの領域とは

仮想メモリは物理メモリの上に置かれた見せかけのメモリ
仮想メモリの領域は
連続したメモリの領域で、例えばページサイズ(4KB)の倍数である
アドレスから始まる
全てのページが同じパーミッションを持つ


### プログラムの実行コードをその実行中に書き換えようとしたらどうなるか

通常コードセグメントは上書きされないように守られている
書き込みのをするとハードウェアの例外の結果となってOSが処理する
OSはプロセスをsegmentation faultとともに殺す。



### what is forbidden address

無効なアドレスであり、値も定義されていない。
アクセスをするとエラーが発生する. segmentation fault.

### what is canonical address

Intel64では64bitの仮想アドレスに対して48bit以降は
bit 47が繰り返されている
現状48bitのアドレス空間で事足りているが拡張を残している

ちなみに仮想アドレスに正しくアクセスしないと
(非正規アドレスを触ると) Bus error が発生する

### what is translation table

仮想メモリのアドレスを物理メモリに対応させる表のこと

- PML4
- PDP
- PD
- PT

### what is page frame

物理アドレス空間において、仮想ページを当てられる複数のスロットのこと
なのでスロットの単位はページサイズに等しい

ページはプロセスが利用するアドレス空間。ここでの単位は4KB

### 仮想アドレス空間とは。物理アドレス空間とは

仮想アドレスはアプリケーションから見えるアドレス

物理アドレスは、ハードウェアに存在するメモリのデータに
アクセスするのに使われる

### what is TLB
TLB Translation Lookaside Buffer

ページアドレスをキャッシュする
CPUの機構
仮想アドレスと論理アドレスとを対応させた情報を一時的に保管しておくバッファメモリ
ページング処理などでメモリが必要になったときに
先に変換情報を持っておくことで高速化を行っている
使う可能性の高いページの先頭に当たる物理アドレスが格納される
