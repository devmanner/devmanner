#include <stdio.h>
#include <stdarg.h>

void foo(int *p, const size_t n) {
  size_t i;
  for (i = 0; i < n; ++i) {
    printf("%d\n", p[i]);
  }
}

#define MK_ARR(a)

/*
void* _MK_ARR(, ...) {
  static typeof(v1) arr[num];
  va_list marker;
  va_start(marker, num);

  for (i = 0; i < num; ++i) {
    arr[i] = 

  }

  return arr;
}
*/

void *p;

int main() {
  foo(
      
      );
  return 0;

}
