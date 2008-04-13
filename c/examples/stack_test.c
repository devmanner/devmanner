#include <stdio.h>
#include "stack.h"

struct foo {
  int x;
  char y;
};


int main() {
  stack(struct foo, fs);
  struct foo f = {10, 'a'};
  stack_push(fs, f);
  


  stack(char, s);
  stack_push(s, 'a');
  stack_push(s, 'b');
  stack_push(s, 'c');
  int x = stack_pop(s);
  printf("popped: %c\n", x);
  x = stack_pop(s);
  printf("popped: %c\n", x);
  x = stack_pop(s);
  printf("popped: %c\n", x);
  printf("size: %d\n", stack_size(s));
  
  stack(int, s1);  
  stack_push(s1, 'a');
  stack_push(s1, 'b');
  stack_push(s1, 'c');
  int y = stack_pop(s1);
  printf("popped: %d\n", y);
  y = stack_pop(s1);
  printf("popped: %d\n", y);
  y = stack_pop(s1);
  printf("popped: %d\n", y);
  printf("size: %d\n", stack_size(s1));
  
  stack_destroy(s1);

  stack_destroy(s);
  stack_destroy(fs);


  
  /*
  deque_push_back(d, 10);
  deque_push_front(d, 11);

  deque_back(d);
  deque_front(d);

  deque_pop_back(d);
  deque_pop_front(d);
  */
  return 0;
}
