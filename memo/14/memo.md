### volatile 変数

コンパイラがどこにも書かれない値をメモリから読み出す命令を省略する
最適化を防御することができる

故に、volatile 変数を使うとその変数の読み書きは必ず発生する
例えば、スレッド間のデータ共有など

### restrict

```c
int* restrict p_x = &x;
```

オブジェクトを指すと、
このオブジェクトに対する全部のアクセスはこのポインタの
値を通じて行いますよ
という約束になる

他のポインタを使った書き込みのせいで
restrict ポインタで格納された値に影響が及ぶことはない
-> Todo const との違いを明確に

### スタックフレーム