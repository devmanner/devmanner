#include <algorithm>
#include <vector>
#include <iterator>
#include <iostream>
#include <cstdio>
#include <cassert>

/* Unsigned 64 bit integer */
typedef unsigned long long u64b;

/* Constants */
const u64b U64MAX = ~0;
const unsigned int MAXSIZE = 10000;

/* Print all numbers from lower to upper except for missing in random order. */
void print_rand(u64b lower, u64b upper, u64b missing) {
  static std::vector<u64b> v;
  unsigned int diff = upper-lower;

  assert(v.empty());
  assert(diff <= MAXSIZE);

  for (unsigned int j = 0; j < diff+1; ++j, ++lower)
    if (lower != missing)
      v.push_back(lower);
#ifndef DBG
  std::random_shuffle(v.begin(), v.end());
#endif
  std::copy(v.begin(), v.end(), std::ostream_iterator<u64b>(std::cout, "\n"));
  v.clear();
}


int main() {
  u64b k[] = {1, 1, 3, 1000, 1};
  u64b n[] = {1, 20, 1000, 4, 3000000};
  u64b missing[] = {1, 2, 2500, 4000, 4};
  unsigned int ntc = sizeof(k)/sizeof(u64b);

#ifdef DBG
  char progress[] = "|/-\\";
  int progcnt = 0;
#endif
  
  srand(time(NULL));

  printf("%u\n", ntc);
  for (unsigned int i = 0; i < ntc; ++i) {
    unsigned int partsize = rand() % (MAXSIZE-1) + 1;
    u64b lower = n[i]*(k[i]-1) + 1;
    u64b upper = k[i]*n[i];
    u64b x;
    printf("%llu %llu\n", k[i], n[i]);

#ifdef DBG
    fprintf(stderr, "Generating testcase number: %d\n", i+1);
    fprintf(stderr, "Lower limit:\t%llu\nUpper limit:\t%llu\nMissing robot:\t%llu\n", lower, upper, missing[i]);
    fprintf(stderr, "Partition size:\t%u\n", partsize);
    fprintf(stderr, "Generating output to stdout... ");
#endif

    for (x = lower; x+partsize < upper; x += partsize) {
      print_rand(x, x+partsize, missing[i]);
      ++x;
      
#ifdef DBG
      /* Print some output to show I'm still running... */
      fprintf(stderr, "\b%c", progress[progcnt = (progcnt + 1) & 0x3]);
#endif
    }

#ifdef DBG
    fprintf(stderr, "\bdone!\n\n");
#endif

    print_rand(x, upper, missing[i]);
  }

#ifdef DBG
    fprintf(stderr, "Successfully created %d test cases.\n", ntc);
#endif
  
  return 0;
}
