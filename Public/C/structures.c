 #include <stdio.h>
    typedef struct {
        char * name;
        int age;
         }person;

 int main(){
    person john;

    john.name = "John";
    john.age = 30;
    printf("%s is %d years old.", john.name, john.age);
 }