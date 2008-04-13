#include <stdio.h>

union itoc {
  unsigned short int i;
  char c[2];
};

int main() {
  unsigned short int i1 = 32016;
  char c1, c2;
  union itoc ic;
  ic.i = i1;


  printf("The union int: %x\nUnion chars: %x %x\n", ic.i, ic.c[1], ic.c[0]);


  c2 = i1;
  c1 = i1 >> 8;
    
  printf("The int: %x\nChars: %x %x\n", i1, c1, c2);
  return 0;
}
