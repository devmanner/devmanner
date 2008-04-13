#include <stdio.h>

int m(int x) {
  return (x << 9) + (x << 8) + (x << 3) + x;
}


int main() {
  int i;
  for (i = 0; i < 10; ++i) {
    if (m(i) != i * 777)
      printf("%d -> %d\n", i, m(i));
  }

  return 0;
}
