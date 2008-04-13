#include <iostream>

template <int ver>
class Tester {
  public:
  Tester() {
    std::cout << "Old ver: " << __GNUC__ << "." << __GNUC_MINOR__ << "." << __GNUC_PATCHLEVEL__ << std::endl;
  }
};
class Tester<3> {
  public:
  Tester() {
    std::cout << "Ok ver: " << __GNUC__ << "." << __GNUC_MINOR__ << "." << __GNUC_PATCHLEVEL__ << std::endl;
#warning ("foobar")
  }
};

Tester<__GNUC__> t;

int main() {
  
}
