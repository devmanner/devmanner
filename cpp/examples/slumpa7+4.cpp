#include <iostream>
#include <set>
#include <algorithm>
#include <iterator>
#include <stdlib.h>

using namespace std;

int main() {
  set<int> base, extra;
  
  do {
    base.insert(rand() % 35 +1);
  } while (extra.size () < 7);

  

  copy(s.begin(), s.end(), ostream_iterator<int>(cout, " "));

  cout << endl;
}
