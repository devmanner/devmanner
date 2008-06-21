#include <iostream>
using namespace std;

namespace {
  class ASingleton {
  public:
    ASingleton() {
    }
    void behave() {
      cout << __PRETTY_FUNCTION__ << endl;
    }
  };
}

template <typename Base>
class Singleton : public Base {
private:
  Singleton() { }
public:
  static Base& get_instance() {
    static Base b;
    return b;
  }
};

typedef Singleton<ASingleton> TheSingleton;

int main() {
  TheSingleton::get_instance().behave();
  system("PAUSE");
  return 0;
}
