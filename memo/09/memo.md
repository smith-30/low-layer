## C 型

ポインタは 0 で初期化することもできるが
NULL が推奨されている

### void\*

どのような種類の型にも対応できるなんでもポインタ
golang でいう `interface{}` 的なやつ

void\*に代入したあとは適切な型でデリファレンスしないとならない

### 配列

同じ型のデータを入れた連続するメモリ領域
要素の方や配列の長さについての情報は
`配列そのものには含まれない`

割り当てた配列の名前を書くのはその配列の先頭アドレスを書くのと同じ
定数のポインタ値だと考えられる

int array[1024] (-> int*)
*array -> array[0] `これ慣れないな`

**配列のインデックスに int を使わない**
`size_t` を使うべき
size_t -> unsigned long (Intel64 では符号なし 8 バイト整数)

例えば、sizeof() が返すのは `size_t`

int は 4 バイト長、max 2^31 - 1
マシンでは 8 バイトまでインデックス参照できるはずなのに
できないことがある

下記のように回してやるとよい

```c
size_t s;
int i;

for (i = 0; i < s; i++) {

}
```

size_t の出力には C99 から `%zu`
それより前では unsigned long に対応する `%lu`

### const

const が*の左にあれば、そのポインタが指すデータが保護される
*の右側に const があればそのポインタが保護される

**変数を const で修飾しても絶対安全ではない**
変更する方法が存在する

関数で受ける際も const にしてやれば、関数内で不変だということを保証できる

```c
int array_sum(const int* array, size_t count) {
     return 0;
}
```

### ローカル変数

```c
// デフォルトで初期化されない、ランダムな値になる
int sum

// こちらが正しい
int sum = 0;
```

### トークン演算子

変数の値を変数名から取れる
シンボルの値を動的にセットできたりする

php の`$$`とかこれ使ってるんだろうな

```c
#define x1 "hello"
#define x2 "world"

#define str(i) x##i

puts(str(1)); // str(1) -> x1
puts(str(2)); // str(2) -> x2
```
