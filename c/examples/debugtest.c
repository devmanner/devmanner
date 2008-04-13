#include <stdio.h>

int main() {
  int i;
  char s[2];
  for (i = 0; i < 10; ++i) {
    printf("%d\n", i);
    if ( i == 5)
      s[2] = 'a';
  }
  return 0;
}
    
