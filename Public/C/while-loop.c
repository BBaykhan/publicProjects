#include <stdio.h>

int main() {
    int n = 0;

    while (n < 10) {
        n++;

        if (n % 2 == 0) {
            printf("The number %d is even.\n", n);
        }
    }

    return 0;
}
