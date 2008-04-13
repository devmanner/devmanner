#include <stdio.h>

int main() {
  char byte1;
  int byte2to5;
  char byte6;

  printf("Addresses are: base: %p byte1=>%p byte2to5=>%p byte6=>%p\n", &byte1, (&byte1)-(&byte1), (&byte2to5)-(&byte1), (&byte6)-(&byte1));

  return 0;
}
