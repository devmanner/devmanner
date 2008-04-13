#include <vector>
#include <iostream>
#include <sstream>
#include <iterator>
#include <algorithm>

using namespace std;

int main() {
  string s = "balle 123 3245 4543 635 435434 32423";
  
  vector<int> v;
  istringstream iss(s);
  int x;
  string tmp;
  iss >> tmp;
  while (iss >> x) {
    v.push_back(x);
  }

  copy(v.begin(), v.end(), ostream_iterator<int>(cout, "-"));
  cout << endl;

  return 0;
}
