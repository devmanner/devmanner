#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>
#include <assert.h>

#define PRIMES (INT_MAX / 8192)
#define MAX_NUM (INT_MAX / 8192)


int is_prime(unsigned int n) {
  int k, limit;
  if (n == 2)
    return 1;
  if ((n & 0x1) == 0)
    return 0;
  limit = n >> 1;
  for (k = 3; k <= limit; k += 2)
    if ((n % k) == 0)
      return 0;
  return 1;
}

void fill_primes(unsigned int *primes) {
  int i;
  int prime_index;
  unsigned int *num = malloc(sizeof(int)*MAX_NUM);
  assert(num);

  for (i = 0; i < MAX_NUM; ++i)
    num[i] = i;

  num[0] = num[1] = 0;

  /* Remove all numbers from num that aren't primes. */
  for (prime_index = 2; prime_index < MAX_NUM; ) {
    for (i = prime_index*2; i < MAX_NUM; i += prime_index)
      num[i] = 0;
    ++prime_index;
    while (!num[prime_index] && prime_index < MAX_NUM)
      ++prime_index;
  }

  /* move all primes to primes. */
  for (i = 0, prime_index = 0; i < MAX_NUM && prime_index < PRIMES; ++i)
    if (num[i])
      primes[prime_index++] = num[i];

  free(num);
}

int factor(unsigned int x, unsigned int *a, unsigned int *primes) {
  unsigned int a_index;
  unsigned int *p_prime;
#ifdef DBG
  printf("begin factorizeing... ");
#endif

  for (a_index = 0, p_prime = primes; *p_prime; ++p_prime) {
    while (!(x % *p_prime)) {
      x /= *p_prime;
      a[a_index++] = *p_prime;
    }
  }
  if (x)
    a[a_index++] = x;
  
#ifdef DBG
  printf("done!\n");
#endif
  
  return a_index;
}

int main() {
  unsigned int primes[PRIMES];
  unsigned int factors[1000];
  unsigned int fac, div;

  memset(primes, 0, PRIMES*sizeof(int));
  fill_primes(primes);
  
  /*
  for (p = primes; *p; ++p)
    printf("%u ", *p);
    printf("\n");
  */
  /*
  fac = ~0;
  printf("%u\n", fac);
  return 0;
  */

  while (scanf("%u %u", &fac, &div) != EOF) { 
    unsigned int i, x, divides = 1;
    unsigned int n_fact = factor(div, factors, primes);
    assert(n_fact);

#ifdef DBG
    printf("factors of %u are: ", div);
    for (i = 0; i < n_fact; ++i)
      printf("%u ", factors[i]);
    printf("\n");
#endif

    if (div <= fac) {
#ifdef DBG
      printf("(div <= fac) ");
#endif
      printf("%u divides %u!\n", div, fac);
      continue;
    }
    else if (factors[n_fact-1] > fac) {
#ifdef DBG
      printf("(factors[n_fact-1] > div) ");
#endif
      printf("%u does not divide %u!\n", div, fac);
      continue;
    }

    for (x = fac; x > 1; --x) {
      unsigned int n_zero = 0;
      unsigned int tmp = x;
      for (i = 0; i < n_fact && n_zero < n_fact && x; ++i) {
	if (!factors[i]) {
	  ++n_zero;
	  continue;
	}
	if (!(tmp % factors[i])) {
	  tmp /= factors[i];
	  factors[i] = 0;
	}
      }
    }

    /* Check for nonzero in factors. */
    for (i = 0; i < n_fact; ++i) {
      if (factors[i]) {
	divides = 0;
	break;
      }
    }

    if (divides)
      printf("%u divides %u!\n", div, fac);
    else
      printf("%u does not divide %u!\n", div, fac);
   
  }
  return 0;
}



