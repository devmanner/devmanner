#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>

int divide(jmp_buf *eb, int x, int y) {
  if (y)
    return x/y;
  longjmp(*eb, 1);
}


int main() {
  jmp_buf environment_buffer;
  int code;
  if ( (code = setjmp(environment_buffer)) ) {
    printf("An error occured... errcode: %d\n", code);
    exit(code);
  }
  
  divide(&environment_buffer, 1, 0);
  printf("After call\n");

  return 0;
}
