#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc == 1) {
        printf("Hello, World!\n");
    } else {
        printf("Hello, %s!\n", argv[1]);
    }
    return 0;
}