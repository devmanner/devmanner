#include <stdio.h>

main() {
        puts("fork test");
        fork();
        puts("fork end");
        return 0;
}