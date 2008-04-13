#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  int *p = new int[10];
  int a[10];

  srand(time(NULL));
  
  for (unsigned int i = 0; i < 10; ++i)
    p[i] = a[i] = rand() % 10 +1;

  printf("{");
  for (unsigned int i = 0; i < sizeof(a)/sizeof(a[0]); ++i)
    printf("%d ", a[i]);

  printf("}\n{");
  for (unsigned int i = 0; i < sizeof(p)/sizeof(p[0]); ++i)
    printf("%d ", p[i]);
  printf("}\n");
 
  return 0;
}
