#include <iostream>

using namespace std;

template<int X>
struct Fac {
  enum { result = X * Fac<X-1>::result };
};

template<>
struct Fac<1> {
  enum { result = 1 };
};

template<bool>
struct Test {};
template<>
struct Test<true> {
  static void assert() {}
};


int main() {
  cout << "Fac 1: " << Fac<1>::result << endl;
  cout << "Fac 2: " << Fac<2>::result << endl;
  cout << "Fac 3: " << Fac<3>::result << endl;
  cout << "Fac 4: " << Fac<4>::result << endl;
  cout << "Fac 5: " << Fac<5>::result << endl;
  cout << "Fac 6: " << Fac<6>::result << endl;
  cout << "Fac 12: " << Fac<12>::result << endl;

  Test<Fac<6>::result == 720>::assert();
  Test<Fac<7>::result == 5040>::assert();
  Test<Fac<8>::result == 40320>::assert();
  Test<Fac<9>::result == 362880>::assert();
  Test<Fac<10>::result == 3628800>::assert();

  return 0;
}
