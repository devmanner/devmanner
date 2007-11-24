#include <stdio.h>
int x=0, y=0;

void a1(void) {
  printf("a1 ");
  x = x + 1;
}
void a2(void) {
  printf("a2 ");
  x = x + 2;
}
void b1(void) {
  printf("b1 ");
  x = x + 2;
}
void b2(void) {
  printf("b2 ");
  y = y - x;
}

int main() {
  x = y = 0; a1(); a2(); b1(); b2(); printf("=> x = %d, y = %d\n", x, y);
  x = y = 0; a1(); b1(); b2(); a2(); printf("=> x = %d, y = %d\n", x, y);
  x = y = 0; b1(); b2(); a1(); a2(); printf("=> x = %d, y = %d\n", x, y);
  x = y = 0; b1(); a1(); b2(); a2(); printf("=> x = %d, y = %d\n", x, y);
  x = y = 0; b1(); a1(); a2(); b2(); printf("=> x = %d, y = %d\n", x, y);
  x = y = 0; a1(); b1(); a2(); b2(); printf("=> x = %d, y = %d\n", x, y);
  return 0;
}
