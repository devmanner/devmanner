#include <stdio.h>

/* CHeck compiler version. */
#ifdef __GNUC__
#if ( __GNUC__ == 3 )
#warning "This program may not compile du to use of an old compiler version"
#endif
#endif

int main() {
  printf("hello world\n");
  return 0;
}
