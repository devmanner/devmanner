#include <memory>
#include <iostream>

using namespace std;

int main() {
  auto_ptr<int> p1(new int(10));
  auto_ptr<int> p2();//p1.release());
  //  auto_ptr<int> p3 = p1;
  auto_ptr<int> p4(p1.release());

  *p4 = 12;
  cout << *p4 << endl;

}
