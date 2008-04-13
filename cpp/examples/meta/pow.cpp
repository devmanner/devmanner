#include <iostream>


template<int N>
class Pow3 {
  public:
    enum { result = 3 * Pow3<N-1>::result };
};

//full specialization to end the recursion}
template<>
class Pow3<0> {
  public:
    enum { result = 1 };
};

// Calc X^Y
template<int X, int Y>
struct Pow {
  enum {result = X*Pow<X,Y-1>::result };
};
template <int X>
struct Pow<X, 0> {
  enum { result = 1 };
};

int main() {
  std::cout << Pow3<4>::result << std::endl;
  std::cout << Pow<100, 10>::result << std::endl;
  
}
