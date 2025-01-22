#include <stdio.h>

int main() {
    int grades[3];
    int average;
    grades[0] = 10;
    grades[1] = 300;
    grades[2] = 40;

    average = (grades[0] + grades[1] + grades[2]) / 3;
    printf("The average of it is: %d", average);

    return 0;
}