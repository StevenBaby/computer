
int compare(int condition, int a, int b)
{
    if (condition)
        return a;
    else
        return b;
}

int main()
{
    compare(1, 2, 3);
    return 0;
}
