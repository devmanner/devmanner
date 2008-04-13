#include <iostream>

using namespace std;

class Singleton {
private:
  static double  m_d;
  static int m_i;
  Singleton() {
    cout << "Creating singleton" << endl;
  }
public:
  /*
  static Singleton& getInstance() {
    static Singleton s;
    cout << "hit" << endl;
    return s;
  }
  */

  static void f1(int i) {
    m_i = i;
    cout << "f1(int): " << i << endl;
  }
  static void f2(double d) {
    m_d = d;
    cout << "f2(double): " << d << endl;
  }
  static void print() {
    cout << "double: " << m_d << " int: " << m_i << endl;
  }
};

int Singleton::m_i = 0;
double Singleton::m_d = 0.0;

template <class T>
class Command {
private:
  T m_value;
  void (*m_ptr)(T);
public:
  Command(T value, void (*ptr)(T)) : m_value(value), m_ptr(ptr) { }
  void execute() {
    m_ptr(m_value);
  }
};

class Foo {
  int m_f;
public:
  Foo(int f=10) : m_f(f) {}
  void func(void) {
    cout << "func() " << m_f << endl;
  }
};


int main() {
  //Singleton::getInstance();
  /*
  Singleton::print();
  Command<int> ci((int)1, Singleton::f1);
  Command<double> cd((double)1.4, Singleton::f2);
  cd.execute();
  ci.execute();
  */
  Foo f(19);
  void (Foo::*p) (void) = f::func;
  p();
  return 0;
}
