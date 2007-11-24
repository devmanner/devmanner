#include <vector>
#include <algorithm>
#include <cstdio>

typedef unsigned long long u64b;

int main() {
  typedef std::vector<u64b> vec_t;
  vec_t v;
  unsigned int ntc;
  scanf("%u", &ntc);
  while (ntc--) {
    u64b k, n;
    scanf("%llu %llu", &k, &n);
    u64b xmin = n*(k-1)+1;
    u64b xmax = k*n;
    v.clear();

    for (unsigned int i = 0; i < xmax - xmin; ++i) {
      u64b tmp;
      scanf("%u", &tmp);
      v.push_back(tmp);
    }
    std::sort(v.begin(), v.end());
    
    if (!v.empty()) {
      vec_t::iterator itr = v.begin();
      ++itr;
      for (vec_t::iterator titr = v.begin(); itr != v.end(); ++itr, ++titr)
	if (*titr+1 != *itr)
	  printf("%llu\n", *titr+1);
    }
    else
      printf("%llu\n", xmax);
  }
  return 0;
}
