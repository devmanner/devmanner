#include <iostream>

using namespace std;

/* Note: Pointers to member functions must be accessed through an instance
 * or a pointer to its class, in this case via the Controller *getInstance().
 */


class Controller {
private:
  double  m_d;
  int m_i;
  
  Controller() : m_d(0), m_i(0) {
    cout << "Creating Controller" << endl;
  }
public:
  static Controller& getInstance() {
    static Controller c;
    return c;
  }

  void fi(int i) {
    m_i = i;
    cout << "f1(int): " << i << endl;
  }
  void fd(double d) {
    m_d = d;
    cout << "f2(double): " << d << endl;
  }
};


template <class T>
class Command {
private:
  T m_value;
  void (Controller::*m_ptr)(T); // Name is now m_ptr
public:
  Command(T value, void (Controller::*ptr)(T))
    : m_value(value), m_ptr(ptr) { }
  void execute() {
    (Controller::getInstance().*m_ptr)(m_value);
  }
};

int main() {
  Command<int> ci(1, &Controller::fi);
  Command<double> cd(2.2, &Controller::fd);
  ci.execute();
  cd.execute();

  return 0;
}
