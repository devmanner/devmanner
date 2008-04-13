#include <stdio.h>

int cbits(int x) {
  int itrs = 0;
  int cnt;
  int px=0xFFFF;
  for (cnt = x & 1; x & px; ) {
    px = x - 1;
    cnt += px & 1;
    x &= px;
    ++itrs;
  }
  printf("Iterations: %d\n", itrs);
  return cnt;
}

int main() {
  int x = 0xFEL;
  printf("Set bits in: 0x%x is: %d\n", x, cbits(x));
  return 0;
}
