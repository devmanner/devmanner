#include <iostream>

using namespace std;

inline int pow2(int x) {
  return x*x;
}

int main() {
  int a,b,c,p,q;

  for (p = 1; p < 500; ++p) {
    for (q = 1; q < p; ++q) {
      a = 2*p*q;
      b = pow2(p) - pow2(q);
      c = pow2(p) + pow2(q);
      if (a + b + c == 1000) {
        cout << "a: " << a << " b: " << b << " c: " << c << ", a*b*c: " << a*b*c << endl;
      }  
    }
  }


  system("PAUSE");
  return 0;
}
