#include <stdio.h>

int main() 
{
    int strlen(const char *str);
    char name[] = "John Whick";
    char name1[] = "I killed your dog!";

    printf ("%s, %s\n", name, name1);


    char * name2 = "John Whitch";
    int age = 243;
    printf ("%s is %d years old. \n", name2, age);

    char * name3 = "What is your name? Ezekiel! Fuck you Ezekiel!!!";
    printf("%d\n",strlen(name3));

    char * name4 = "Robert";

    if (strncmp(name4, "Robert", 6) == 0){
        printf("What's up Robert!\n");
    }   
        else {
        printf("Who the fuck are you???\n");
    }

    char dest[20]="Hello";
    char src[20]="World";
    strncat(dest,src,3);
    printf("%s\n",dest);
    strncat(dest,src,20);
    printf("%s\n",dest);

    return 0;
} 