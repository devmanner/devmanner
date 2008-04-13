#include <iterator>
#include <algorithm>
#include <vector>
#include <iostream>
#include <fstream>

class A {
public:
  unsigned long getId() const {
    return reinterpret_cast<unsigned long>(this);
  }
  friend std::ostream &operator<<(std::ostream &, A &);
};

std::ostream& operator<<(std::ostream &os, const A &a) {
  os << "My id is: " << a.getId();
  return os;
}


class ASorter {
public:
  bool operator()(const A &a1, const A &a2) {
    return (a1.getId() < a2.getId());
  }
};

int main() {
  typedef std::vector<A> vec_t;
  vec_t v;
  for (int i = 0; i < 10; ++i) {
    A a;
    v.push_back(a);
  }
  std::random_shuffle(v.begin(), v.end());

  std::copy(v.begin(), v.end(), std::ostream_iterator<A>(std::cout, "\n"));

  std::endl(std::cout);

  ASorter s;
  std::sort(v.begin(), v.end(), s);
  
  std::copy(v.begin(), v.end(), std::ostream_iterator<A>(std::cout, "\n"));

  return 0;
}
