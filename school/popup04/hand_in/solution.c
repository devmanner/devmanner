#include <stdio.h>

#include <stdlib.h>

typedef unsigned long long u64b;

#ifdef OLD_VER
/* Old version, slower on glibc 1.2.10 but working... */
u64b read_add(unsigned int num) {
  u64b tmp, sum = 0;
  int i;
  for (i = 0; i < num; ++i) {
    scanf("%llu", &tmp);
    sum += tmp;
  }
  return sum;
}

#else /* Not OLD_VER */
/* Chomp off \n from a string and count characters in string. */
int chomp(char *s) {
  char *p;
  for (p = s; *p; ++p)
    if (*p == '\n' || *p == '\0') {
      *p = '\0';
      return p-s;
    }
  return p-s;
}

/* Read num 64 bit integers and add them. */
u64b read_add(unsigned int num) {
  static const u64b pot[] = {1LL, 10LL, 100LL, 1000LL, 10000LL, 100000LL, 1000000LL,
			     10000000LL, 100000000LL, 1000000000LL, 10000000000LL,
			     100000000000LL, 1000000000000LL, 10000000000000LL,
			     100000000000000LL, 1000000000000000LL,
			     10000000000000000LL, 100000000000000000LL,
			     1000000000000000000LL};
  char buff[64];
  u64b sum = 0;
  char *p;
  unsigned int n_read;
  int pot_i;
  int n_readc;

  for (n_read = 0; n_read < num; ++n_read) {
    fgets(buff, 64, stdin);
    /* This atoll is faster but more insecure than the standard (glibc) atoll(). */
    n_readc = chomp(buff);
    for (pot_i = 0, p = buff; *p; ++p, ++pot_i) {
      sum += (*p - '0') * pot[n_readc - pot_i - 1];
    }
  }

  return sum;
}
#endif /* OLD_VER */

int main() {
  unsigned int ntc;
  scanf("%u", &ntc);
  while (ntc --) {
    u64b k, n;
    scanf("%llu %llu", &k, &n);
    u64b xmin = n*(k-1)+1;
    u64b xmax = k*n;
    /* The sum we're expecting. */
    u64b S = (xmax+xmin) * (xmax-xmin+1) / 2;
    u64b sum = 0;
    u64b missing;

#ifdef DBG
    printf("k: %llu n: %llu\n", k, n);
    printf("xmax: %llu xmin: %llu\n", xmax, xmin);
    printf("S: %llu\n", S);
#endif

#ifndef OLD_VER
    /* Hack hack... */
    char c[10];
    fgets(c, 10, stdin);
#endif

    sum = read_add(xmax-xmin);
    missing = S-sum;
    if (missing)
      printf("missing: %llu\n", missing);
  }
  return 0;
}
