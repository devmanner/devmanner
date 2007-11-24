#include <stdio.h>

typedef unsigned long long u64b;

int chomp(char *s) {
  char *p;
  for (p = s; *p; ++p)
    if (*p == '\n') {
      *p = '\0';
      return p-s;
    }
  return p-s;
}

u64b read_add(unsigned int num) {
  static const u64b pot[] = {1, 10, 100, 1000, 10000, 100000, 1000000,
			     10000000, 100000000, 1000000000, 10000000000,
			     100000000000, 1000000000000, 10000000000000,
			     100000000000000, 1000000000000000,
			     10000000000000000, 100000000000000000,
			     1000000000000000000};
  char buff[25];
  u64b sum = 0;
  char *p;
  int n_read;
  int pot_i;
  int n_readc;

  for (n_read = 0; n_read < num; ++n_read) {
    fgets(buff, 25, stdin);
    n_readc = chomp(buff);
    for (pot_i = 0, p = buff; *p; ++p, ++pot_i) {
      sum += (*p - '0') * pot[n_readc - pot_i - 1];
    }
  }

  return sum;
}

int main() {
  u64b x = read_add(2);
  printf("%lld\n", x);
  
  return 0;
}
