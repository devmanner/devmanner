#include <stdio.h>

int main() {
  int i;
  for (i = 0; i < 10; ++i)
    printf("%d %% %d = %d\n", i, 4, i & 3);

  return 0;
}
