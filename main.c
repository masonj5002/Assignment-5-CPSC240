#include <stdio.h>
#include <string.h>

extern const char* series();

int main(int argc, char* argv[]) {

    printf("Welcome to Taylor Series by Mason Jennings\n");
    printf("This software will compute any power of e that you may need.\n\n");

    series();

    return 0;
}