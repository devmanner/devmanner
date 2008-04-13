#include <string>
#include <iostream>
#include <algorithm>
#include <ctype.h>

using namespace std;

int main() {
  string s = "KaLlE bAlLe";
  transform(s.begin(), s.end(), s.begin(), toupper);
  cout << s << endl;
}
