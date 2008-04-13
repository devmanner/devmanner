#include <stdio.h>

void swap(int *x, int *y) {
  *x ^= *y ^= *x ^= *y;
}

int main() {
  int i;
  for (i = 0; i < 10; ++i) {
    int y = i + 10, x = i;
    printf("x: %d, y: %d\n", x, y);
    swap(&x, &y);
    printf("x: %d, y: %d\n\n", x, y);
  }
  return 0;
}
