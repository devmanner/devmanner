#include <stdio.h>
#include <limits.h>

/* Calculate x^y */
long long pow(long long x, int y) {
  return (!y) ? 1 : x * pow(x, y-1);
}

#define ABS(x) ((x < 0) ? -x : x)

int main() {
  int foo;

  while (scanf("%d", &foo) != EOF && foo) {
    /* x = b^p */
    long long int x = (long long int) foo;
    int p = 1;
    long long int b = 2;
    int result = 0;
    long long int powr = 0;

    if (x > 0) {
      for (b = 2; b <= x && !result && x >= pow(b, 2); ++b) {
	for (p = 2; p <= 31; ++p) {
	  powr = pow(b, p);
#ifdef DBG
	  printf("%lld^%d = %lld\n", b, p, powr);
#endif
	  if (powr > x)
	    break;
	  else if (powr == x) {
	    result = p;
	    break;
	  }
	}
      }
    }
    else {
      /* Try with b < 0 */
      for (b = -2; b >= x && !result && x <= pow(b, 3); --b) {
	for (p = 3; p <= 31; p += 2) {
	  powr = pow(b, p);
#ifdef DBG
	  printf("%lld^%d = %lld\n", b, p, powr);
#endif
	  if (powr < x)
	    break;
	  else if (powr == x) {
	    result = p;
	    break;
	  }
	}
      }
    }
    if (!result)
      result = 1;
    printf("%d\n", result);
  }
  return 0;
}
