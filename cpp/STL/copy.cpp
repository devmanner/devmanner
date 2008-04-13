#include <algorithm>
#include <iostream>
#include <list>
#include <iterator>
#include <vector>
#include <string>
#include <deque>
#include <stdlib.h>

using namespace std;

int main() {
  list<int> l;
  vector<int> v;
  deque<int> d;

  srand(time(NULL));
  for (int i = 0; i < 10; ++i)
    l.push_back(rand()%10+1);

  copy(l.begin(), l.end(), back_inserter(v));
  copy(l.begin(), l.end(), ostream_iterator<int>(cout, " "));
  cout << endl;
  copy(v.begin(), v.end(), ostream_iterator<int>(cout, " "));
  cout << endl;

  copy(v.rbegin(), v.rend(), back_inserter(d));
  copy(d.begin(), d.end(), ostream_iterator<int>(cout, " "));
  cout << endl;


}
