#include <stdio.h>

int main() {
  register i; // Ok i C90, fel i C++ och C99 
  for (i = 0; i < 10; ++i)
    printf("%d\n", i);
  
  char c; // Ok i C99 och C++, fel i C90
  const int SIZE = 10; // Ok i C++
  
}
