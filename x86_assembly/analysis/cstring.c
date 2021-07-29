
#include <stdio.h>
#include <time.h>

#define NULL 0

typedef unsigned int size_t;

void *amemcpy(void *dest, const void *src, size_t count);

void *memcpy(void *dest, const void *src, size_t count)
{
    char *dptr = dest;
    const char *sptr = src;
    for (size_t i = 0; i < count; i++)
    {
        dptr[i] = sptr[i];
    }
    return dest;
}

char message[] = "hello world!!!\n";
char buffer[sizeof(message)];

int main(int argc, char const *argv[])
{
    printf("%d\n", time(NULL));
    int total = 100000000;
    int count = total;
    while (count--)
    {
        memcpy(buffer, message, sizeof(message));
    }

    printf("%d\n", time(NULL));

    count = total;
    while (count--)
    {
        amemcpy(buffer, message, sizeof(message));
    }

    printf("%d\n", time(NULL));

    return 0;
}
