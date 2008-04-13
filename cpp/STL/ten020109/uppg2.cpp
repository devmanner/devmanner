#include <iostream>
#include <iterator>
#include <algorithm>
#include <string>
#include <list>
using namespace std;

int main() {
  istream_iterator<string> itr(cin);
  string s;
  list<string> l;
  int i = 0;
  do {
    l.push_back(*itr);
    ++itr;
  } while (++i < 2);
  l.push_back(*itr);

  l.sort();

  cout << "Out:" << endl;

  unique_copy(l.begin(), l.end(), ostream_iterator<string>(cout, " "));
  cout << endl;
}
