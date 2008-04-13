#include <stdio.h>
#include <math.h>

unsigned int fac(unsigned int n) {
  int ret = 1, i;
  if (!n)
    return 1;
  for (i = 0; i < n; ++i)
    ret *= i;
  return ret;
}

int main() {
  int n;
  float tpi;
  for (n = 0; n < 2; ++n) {
    tpi += ((n/4)*(n/2)*(3*n/4)/
	    pow(fac(n),3))*
      (2*sqrt(2)*(1103+26390*n))*1/pow(99*99,2*n+1);
  }
  printf("PI: %f\n", 1/tpi);
  return 0;
}
