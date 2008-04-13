#include <string>
#include <iostream>

using namespace std;

int main() {
  string s1("G13");
  int i = atoi(&((s1.c_str())[1]));
  cout << i << endl;

  string s2("X-1.55");
  double d = atof(&((s2.c_str())[1]));
  cout << d << endl;
  

  return 0;
}
