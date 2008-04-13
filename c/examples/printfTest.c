#include <stdio.h>

int main() {
  printf("normal %c[1m bold, %c[0m %c[7m reverse %c[0m\n",27,27,27,27);
  printf("Octal: \0123\n");
  printf("Backspace after this\b\b  \n");
  return 0;
}
