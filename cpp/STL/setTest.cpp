#include <set>
#include <iostream>
#include <stdlib.h>

using namespace std;

int main() {
  set<int> s;
  srand(time(NULL));

  for (int i = 0; i < 10; ++i) 
    s.insert(rand() % 100);
  
  set<int>::iterator itr;

  for (itr = s.begin(); itr != s.end(); ++itr)
    cout << *itr << endl;

  for (itr = s.begin(); itr != s.end(); ++itr)
    *itr = (*itr)+1;

  for (itr = s.begin(); itr != s.end(); ++itr)
    cout << *itr << endl;

  return 0;
}
