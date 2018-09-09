#include <stdio.h>

long array[] = {11, 22, 33, 88};

int main(void)
{
    printf("%zu \n", sizeof(array));    //　配列数 * 8 = 32
    printf("%zu \n", sizeof(array[0])); // long だから1要素は8バイト
    // sizeof(array) / sizeof(array[0]) = array num
    return 0;
}