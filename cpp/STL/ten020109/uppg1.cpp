#include <iostream>
using namespace std;

class Class {
private:
  int m_n;
public:
  Class(int n) : m_n(n){ cout << "Konstruktor" << endl;}
  ~Class() {}
  double operator()(){ return (double) m_n; }
};

int main() {
  Class a(2);
  double n = a();
  cout << n << endl;
}
