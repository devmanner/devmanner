#include <map>
#include <set>
#include <iostream>
#include <algorithm>
#include <stdlib.h>

using namespace std;

typedef map<int, int, less<int> > map_type;
typedef multiset<int, less<int> > set_type;

template <class T>
map<T, int, less<T> > ms2m(const multiset<T, less<T> > &s) {
  map<T, int, less<T> > m;
  set<T, less<T> > tmp(s.begin(), s.end());
  for (typename set<T, less<T> >::iterator itr = tmp.begin();
       itr != tmp.end();
       ++itr)
    m.insert(typename map<T, int, less<T> >::value_type(*itr, count(s.begin(), s.end(), *itr)));
  return m;
}

int main() {
  set_type mset;
  
  srand(time(NULL));
  for (int i = 0; i < 10; ++i)
    mset.insert(rand()%10 +1);
  
  map_type m = ms2m(mset);
  
  cout << "Set: ";
  for (set_type::iterator itr = mset.begin(); itr != mset.end(); ++itr)
    cout << *itr << " ";
  cout << endl << "Map: ";
  for (map_type::iterator itr = m.begin(); itr != m.end(); ++itr){
    for (int i = 0; i < (*itr).second; ++i)
      cout << (*itr).first << " ";
  }
  cout << endl;
}
