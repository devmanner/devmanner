#include <stdio.h>
#include <exception.h>
#include <wait_for_enter.h>

enum {EXCEPTION_F1=0, EXCEPTION_NOT_THROWN};

void f1(void) {
  puts(__PRETTY_FUNCTION__);
  THROW(EXCEPTION_F1, "Exception in f1!!!");
}

void f2(void) {
  puts(__PRETTY_FUNCTION__);
}

int main() {
  EXCEPTION ex;
  
  TRY {
    f1();
    f2();
  }
  CATCH(ex) {
    switch(GET_EXCEPTION_TYPE(ex)) {
    case EXCEPTION_NOT_THROWN:
      printf("Exception: <%s>\n", GET_MESSAGE(ex));      
      break;
    case EXCEPTION_F1:
      printf("Exception: <%s>\n", GET_MESSAGE(ex));      
      break;
    default:
      printf("Some other exception: <%s>\n", GET_MESSAGE(ex));
      break;
    }
  }
  CLEAR_EXCEPTION(ex);
  
  pause();
  return 0;
} 
