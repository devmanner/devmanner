#include <algorithm>
#include <vector>
#include <iterator>
#include <iostream>

#include <cstdlib>

using namespace std;

template <typename Iterator>
bool is_sorted(Iterator itr1, Iterator itr2) {
  for (Iterator itr = itr1; itr1 != itr2; ++itr1) {
    ++itr;
    if (*itr1 <= *itr)
      return false;
  }
  return true;
}


template <typename Iterator>
void bogo_sort(Iterator itr1, Iterator itr2) {
  while(!is_sorted(itr1, itr2))
    std::random_shuffle(itr1, itr2);
}

int main() {
  std::vector<int> l;
  srand(time(NULL));

  for (int i = 0; i < 3; ++i)
    l.push_back(rand()%20);

  std::copy(l.begin(), l.end(), std::ostream_iterator<int>(std::cout, " "));
  std::cout << std::endl;

  bogo_sort(l.begin(), l.end());

  std::copy(l.begin(), l.end(), std::ostream_iterator<int>(std::cout, " "));
  std::cout << std::endl;
}
