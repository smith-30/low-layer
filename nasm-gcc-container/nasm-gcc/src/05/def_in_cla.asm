# flag というシンボルが%defineで定義されていたら
# if 内部が実行される
%ifdef flag
hellostring: db "Hello",0
%endif