#include <stdio.h>
int runner() {
    static int count = 0;
    count++;
    return count;
}

int main ()
{
    printf("%d\n", runner());
    printf("%d", runner());
    return 0;
}