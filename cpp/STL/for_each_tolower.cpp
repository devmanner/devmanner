#include <algorithm>
#include <string>
#include <iostream>

#include <cctype>


using namespace std;

struct Tolower {
  void operator()(char &c) { c = tolower(c); }
};


int main() {
  string s = "Kalle Balle HeTer jag едж.";
  for_each(s.begin(), s.end(), Tolower());
  cout << s << endl;
  return 0;
}
