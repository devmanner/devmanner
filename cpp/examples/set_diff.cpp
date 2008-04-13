#include <set>
#include <algorithm>
#include <iterator>
#include <iostream>
#include <cstdio>

int main() {
  std::set<int> all;
  std::set<int> odd;

  for (int i = 1; i <= 10; ++i) {
    all.insert(i);
    if (i & 0x1)
      odd.insert(i);
  }
  
  std::set<int> even;

  std::set_difference(all.begin(), all.end(), odd.begin(), odd.end(), std::insert_iterator<std::set<int> >(even, even.begin()));

  printf("All: ");
  std::copy(all.begin(), all.end(), std::ostream_iterator<int>(std::cout, " "));
  printf("\nodd. ");
  std::copy(odd.begin(), odd.end(), std::ostream_iterator<int>(std::cout, " "));
  printf("\neven. ");
  std::copy(even.begin(), even.end(), std::ostream_iterator<int>(std::cout, " "));
  printf("\n");
}
