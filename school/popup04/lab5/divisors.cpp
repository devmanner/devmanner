#include <set>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cassert>
#include <climits>

#define MAX_FACTORS 64
#define PRIMES (INT_MAX / 8192)
#define MAX_NUM (46340+1000) /* sqrt(2^31 - 1) + 1000 */

void fill_primes(unsigned int *primes) {
  int i;
  int prime_index;
  unsigned int *num = (unsigned int *)malloc(sizeof(int)*MAX_NUM);
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

  if (x == 1) {
    a[0] = 1;
    return 1;
  }

  for (a_index = 0, p_prime = primes; *p_prime; ++p_prime) {
    while (!(x % *p_prime)) {
      x /= *p_prime;
      a[a_index++] = *p_prime;
    }
  }
  if (x != 1)
    a[a_index++] = x;
  
#ifdef DBG
  printf("done!\n");
#endif
  
  return a_index;
}


/*
 * Calculate n choose r which is  /n\
 *                                \r/
 */
unsigned int choose(unsigned n, unsigned int r) {
  if (r == 1)
    return n;
  else if (n == r || !r)
    return 1;
  return (choose(n-1, r-1) + choose(n-1, r));
}

int main() {
  unsigned int primes[PRIMES];
  int n_tc;

  memset(primes, 0, PRIMES*sizeof(int));
  fill_primes(primes);

  scanf("%d", &n_tc);

  while (n_tc--) {
    int lower, upper, x, n_fact;
    unsigned int factors[MAX_FACTORS];
    int max_divs = -1, max_num = 0;
 
    scanf("%d %d", &lower, &upper);
    for (x = lower; x <= upper; ++x) {
      unsigned int powers[MAX_FACTORS] = {1};
      int n_divs = 1;
      unsigned int i, ipow;
      unsigned int *p;

      if (x != 1) {
	n_fact = factor(x, factors, primes);
	
#ifdef DBG
	printf("\nFactors of %d are: ", x);
	for (i = 0; i < n_fact; ++i)
	  printf("%d ", factors[i]);
	printf("\n");
#endif
	
	for (i = 0, ipow = 0; i < n_fact-1; ++i) {
	  if (factors[i] == factors[i+1])
	    powers[ipow]++;
	  else {
	    powers[++ipow]++;
	  }
	}
	
	for (p = powers; *p; ++p)
	  n_divs *= (*p+1);
	
#ifdef DBG
	printf("powers: ");
	for (p = powers; *p; ++p) {
	  printf("%d ", *p);
	}
	printf("\n");      
	printf("%d has %d divisors\n", x, n_divs);
#endif
      }
      else 
	n_divs = 1;
      if (n_divs > max_divs) {
	max_divs = n_divs;
	max_num = x;
      }
    }
    printf("Between %d and %d, %d has a maximum of %d divisors.\n", lower, upper, max_num, max_divs);
    
  }

  return 0;
}
