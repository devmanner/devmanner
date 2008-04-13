#include <stdio.h>
#include <time.h>

main () {
        printf("Time since UNIX start: %d\nSeconds left to 1000 000 000: %d\n", time(NULL), 1000000000 - time(NULL));
        return 0;
}