#include <stdio.h>

int x, y;

void s1(void) {
  printf("S1 ");
  x = x + y;
}
void s2(void) {
  printf("S2 ");
  y = x - y;
}
void s3(void) {
  printf("S3 ");
  x = x - y;
}


int main() {
  /* A */
  printf("A:\n");
  x = 2;
  y = 5;
  s1();
  s2();
  s3();
  printf("=> x = %d, y = %d\n", x, y);
  
  /* B */
  printf("B:\n");

  x = 2;  y = 5;
  s1(); s2(); s3();
  printf("=> x = %d, y = %d\n", x, y);
  
  x = 2;  y = 5;
  s1(); s3(); s2();
  printf("=> x = %d, y = %d\n", x, y);
  
  x = 2;  y = 5;
  s2(); s1(); s3();
  printf("=> x = %d, y = %d\n", x, y);
  
  x = 2;  y = 5;
  s2(); s3(); s1();
  printf("=> x = %d, y = %d\n", x, y);
  
  x = 2;  y = 5;
  s3(); s1(); s2();
  printf("=> x = %d, y = %d\n", x, y);
  
  x = 2;  y = 5;
  s3(); s2(); s1();
  printf("=> x = %d, y = %d\n", x, y);
  


  return 0;
}
