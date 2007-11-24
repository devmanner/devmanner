#include <set>
#include <list>
#include <algorithm>
#include <iterator>
#include <iostream>
#include <cstdio>
#include <cassert>

using namespace std;

typedef multiset<unsigned int> cont_t;

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

/* x shall be a prime! */
unsigned int next_prime(unsigned int x) {
  if (x == 2)
    return 3;
  x += 2;
  while (!is_prime(x))
    x += 2;
  return x;
}

void factor(unsigned int x, cont_t &res) {
  int num = 2;
  while (!is_prime(x)) {
    if (!(x % num)) {
      res.insert(num);
      x /= num;
      continue;
    }
    num = next_prime(num);
  }
  res.insert(x);
}

int main() {
  unsigned int fac, div;
  cont_t res;

  while (scanf("%d %d", &fac, &div) != EOF) {
    factor(div, res);
    /*
    printf("Factorization of: %d is: ", div);
    copy(res.begin(), res.end(), ostream_iterator<unsigned int>(cout, " "));
    printf("\n");
    */
    for (unsigned int x = 2; x <= fac; ++x)
      for (cont_t::iterator itr = res.begin(); itr != res.end(); ++itr) {
	if ((x % *itr) == 0)
	  res.erase(itr);
      }
    
    
    if (res.empty())
      printf("%d divides %d!\n", div, fac);
    else
      printf("%d does not divide %d!\n", div, fac);
    
    res.clear();
    
  }
  return 0;
}
