#include <stdio.h>
#include <stdlib.h>

void binPrint (int num);

int main(int argc, char *argv[]) {
  int i;
  if (argc == 1) {
    printf("Usage: binPrint numer [number] ...\n");
    return 1;
  }

  printf("Decimal:\tBinary:\n");
  for (i = 1; i < argc; ++i) {
    binPrint(atoi(argv[i]));
    printf("\n");  
  }
  printf("\n");
  return 0;
}

void binPrint (int num) {
  int pos, fst=1;
  int mask = 0x1;
  printf("%d\t\t", num);

  /* Find the firts set bit. */
  for (pos = 1; pos < sizeof(num)*8; ++pos) {
    if (mask & num)
      fst = pos;
    mask = mask << 1;
  }

  mask = 0x1;
  mask = mask << fst;
  for (pos = fst; pos >= 0; --pos) {
    printf("%d", (num & mask) ? 1 : 0);
    if (!((pos) % 4))
      printf(" ");
    mask = mask >> 1;
  }
}
