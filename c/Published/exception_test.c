#include <stdio.h>
#include "exception.h"

#define EXCEPTION_F1 1
#define EXCEPTION_F2 2

void f1(void) {
  printf("f1()\n");
  THROW(EXCEPTION_F1, "Exception in f1!!!");
}

void f2(void) {
  printf("f2()\n");
  THROW(EXCEPTION_F2, "Exception in f2!!!");
}


int main() {
  EXCEPTION ex;
  TRY {
	  f1();
	  f2();
  }
  CATCH(ex) {
    switch(GET_EXCEPTION_TYPE(ex)) {
    case EXCEPTION_F1:
      printf("ex1 %s\n", GET_MESSAGE(ex));
      break;
    case EXCEPTION_F2:
      printf("ex2 %s\n", GET_MESSAGE(ex));
      break;
    default:
      printf("Unknown exception: %s\n", GET_MESSAGE(ex));
      break;
    }
	CELAR_EXCEPTION(ex);
  }

  TRY {
	  f2();
  }
  CATCH(ex) {
    switch(GET_EXCEPTION_TYPE(ex)) {
    case EXCEPTION_F1:
      printf("ex1 %s\n", GET_MESSAGE(ex));
      break;
    case EXCEPTION_F2:
      printf("ex2 %s\n", GET_MESSAGE(ex));
      break;
    default:
      printf("Unknown exception: %s\n", GET_MESSAGE(ex));
      break;
    }
	CELAR_EXCEPTION(ex);
  }

  return 0;
}
