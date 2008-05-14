#include <algorithm>
#include <iterator>
#include <vector>
#include <iostream>


int main() {
  std::vector<int> v;
  std::copy(std::istream_iterator<int>(std::cin), std::istream_iterator<int>(), std::back_inserter(v));

  std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, " "));


  system("PAUSE");
  return 0;
}
