
char message[] = "hello kernel!!!";

int main()
{
    char *video = (char *)0xb8000;

    for (int i = 0; i < sizeof(message); i++)
    {
        *video = message[i];
        video++;
        *video = 0b00100101;
        video++;
    }

    return 0;
}
