#include <stdio.h>

void g(void){ printf("g()\n");}
void f(void){ printf("f()\n");}

void ex4(int a) {
  void (*x) (void) = f + a * (g - f);
  x();
}

int main() {
  printf("ex4(0): ");
  ex4(0);
  printf("ex4(1): ");
  ex4(1);
  return 0;
}
