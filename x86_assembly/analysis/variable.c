
#include <stdio.h>

int add(int a, int b)
{
    int c = a + b;
    return c;
}

int main()
{
    int i = 5;
    int j = 10;
    int k = add(i, j);
    printf("%d + %d = %d\n", i, j, k);
}
