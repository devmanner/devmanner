#include <map>
#include <iostream>
#include <string>

typedef map<string, int, less<string> > map_type;
//typedef map_type::value_type value_type;

string s[] = {"kalle", "lisa", "pelle", "olle", "per"};

bool update(map_type &m, map_type::value_type v) {
  map_type::iterator itr = m.find(v.first);
  if (itr == m.end())
    return false;
  (*itr).second = v.second;
  return true;
}

int main() {
  map_type m;
  for (int i = 0; i < 5; ++i)
    m.insert(map_type::value_type(s[i], i));

  cout << "update: " << update(m, map_type::value_type("pelle", 10)) << endl;

  for (map_type::iterator itr = m.begin(); itr != m.end(); ++itr)
    cout << (*itr).first << " -> " << (*itr).second << endl;
}
