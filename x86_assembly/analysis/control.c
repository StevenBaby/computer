
int compare(int condition, int a, int b)
{
    for (int i = 0; i < 10; i++)
    {
        if (condition)
            continue;
        else
            break;
    }
}

int main()
{
    compare(1, 2, 3);
    return 0;
}

void test()
{
    int a = 1;
    int b = 2;
    int c = 3;
    if (a == 3)
    {
        b++;
        if (b == 5)
        {
            a++;
            if (c == 6)
            {
                c++;
            }
            goto label;
        }
        else if (b == 6)
        {
            a++;
        }
    }
    else
    {
        a++;
    }

label:
    a++;
}
