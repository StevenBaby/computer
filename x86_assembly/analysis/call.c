
#include <stdio.h>

extern int add(int a, int b);
extern int __attribute__((fastcall)) sub(int a, int b);

int main()
{
    int i = 5;
    int j = 10;
    // int k = add(i, j);
    int k = sub(i, j);
    printf("%d - %d = %d\n", i, j, k);
}
