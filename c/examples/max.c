#include <stdio.h>

int max(int x, int y) {
  return (x + y) / 2.0 + (x - y) / 2.0;
}

int main() {
  int a = -7, b = 42;
  printf("max(%d, %d) = %d\n", a, b, max(a, b));
  return 0;
}
