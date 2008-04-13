#include <string.h>
#include <stdio.h>

void lshift(int *a, int n) {
  memmove(a+n, a, 4*sizeof(int));
  memset(a, 0, n*sizeof(int));
}

int main() {
  int a[] = {1, 2, 3, 4, 0, 0, 0, 0, 0};
  int i;
  
  lshift(a, 0);

  for (i=0; i < sizeof(a)/sizeof(int); ++i)
    printf("%d ", a[i]);
  printf("\n");

  return 0;
}
