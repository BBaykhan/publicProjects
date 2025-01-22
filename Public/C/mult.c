#include <stdio.h>

int main() {
    int grades[2][5];
    float average;
    int i;
    int j;

    grades[0][0] = 40;
    grades[0][1] = 50;
    grades[0][2] = 60;
    grades[0][3] = 70;
    grades[0][4] = 80;

    grades[1][0] = 50;
    grades[1][1] = 60;
    grades[1][2] = 70;
    grades[1][3] = 80;
    grades[1][4] = 90;

    for(i = 0; i < 2; i++){
        average = 0;
        for (j = 0; j < 5; j++) {
            average += grades [i][j];
        }
        average /= 5.0;
        printf("The average marks in %d is: %.2f\n", i, average);
    }
        return 0;
}