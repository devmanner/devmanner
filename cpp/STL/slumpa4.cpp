#include <iostream>
#include <set>
#include <algorithm>
#include <iterator>
#include <stdlib.h>

using namespace std;

int main() {
  set<int> s;
  do {
    s.insert(rand() % 10 +1);
  } while (s.size () < 4);

  copy(s.begin(), s.end(), ostream_iterator<int>(cout, " "));
  cout << endl;
}
