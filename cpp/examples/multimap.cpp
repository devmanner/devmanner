#include <map>
#include <iostream>
#include <string>

using namespace std;

typedef multimap<int, string, greater<int> > maptype;

int main() {
  maptype mm;
  mm.insert(maptype::value_type(2, "Adam"));
  mm.insert(maptype::value_type(10, "Xerxes"));
  mm.insert(maptype::value_type(11, "Caesar"));
  mm.insert(maptype::value_type(9, "Kalle"));
  mm.insert(maptype::value_type(9, "Karl"));


  for (maptype::iterator itr = mm.begin(); itr != mm.end(); ++itr)
    cout << (*itr).first << " -> " << (*itr).second << endl;

  return 0;
}
