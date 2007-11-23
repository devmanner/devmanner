#include <stdio.h>

#include <wait_for_enter.h>

#include "intset.h"

#undef assert
#define assert(x) do_assert(x, __LINE__, #x)
void do_assert(int val, unsigned int line, const char *s) {
  if (!val) {
    printf("Assertion failed on line %d: %s\n", line, s);
    pause();
    exit(-1);
  }
}

int main() {
  int i;
  int_set s, s2, s3;
  is_init(&s, 100);
  is_init(&s2, 100);
  is_init(&s3, 100);
  
  assert(is_empty(&s));
  
  for (i = 0; i < 100; i += 2)
    is_insert(&s, i);
  
  assert(!is_empty(&s));
  
  for (i = 0; i < 100; i += 2)
    assert(is_find(&s, i));
  
  for (i = 1; i < 100; i += 2)
    is_insert(&s2, i);
  
  is_union(&s, &s2, &s3);
  
  for (i = 0; i < 100; i++)
    assert(is_find(&s3, i));
  
  is_clear(&s3);
  is_intersect(&s, &s2, &s3);
  assert(is_empty(&s3));
  
  is_insert(&s, 1);
  is_intersect(&s, &s2, &s3);
  assert(!is_empty(&s3));
  for (i = 0; i < 100; ++i) {
    if (i == 1)
      assert(is_find(&s3, i));
    else
      assert(!is_find(&s3, i));
  }            
  
  pause();
  return 0;
}
