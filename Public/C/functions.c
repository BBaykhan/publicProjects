#include <stdio.h>
int foo(int bar);
int main () {

    printf ("The value of foo is %d", foo(1));
    }

    int foo(int bar) {
        return bar + 1;
    }