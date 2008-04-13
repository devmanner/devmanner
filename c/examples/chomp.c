#include <stdio.h>
#include <string.h>

void chomp(char *str) {
    for (char *p = str + strlen(str) - 1; *p == '\0' || *p == ' ' || *p == '\n'; --p) {
	*p = '\0';
    }
}

int main() {
    char a[] = "foobar\n   \n \0 ";
    chomp(a);
    printf("<%s>\n", a);

}
