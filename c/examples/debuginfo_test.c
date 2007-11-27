#include <stdio.h>
#include <wait_for_enter.h>

#define DEBUG_MODE
#include <debuginfo.h>

const char* foo(void) { return "This is foo!"; }
int bar(void) { return 42; }

int main() {
  {
    int x = 10;
    DBG(x);    
  }
  {
    double d = 3.14;
    DBG(d);
  }
  DBG(bar());
  DBG(foo());
  
  pause();
  return 0;  
}
