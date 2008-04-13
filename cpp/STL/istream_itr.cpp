#include <iostream>
#include <iterator>
#include <string>
#include <list>
#include <algorithm>

int main() {
  cout << "Enter something (q quits):" << endl;

  istream_iterator<string> itr(cin);
  list<string> slist;

  do {
    slist.push_back(*itr);
    ++itr;
  } while (*itr != "q");

  cout << "[";
  copy(slist.begin(), slist.end(), ostream_iterator<string>(cout, ", "));
  cout << "]" << endl;
}
