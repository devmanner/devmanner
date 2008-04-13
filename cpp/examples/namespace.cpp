#include <algorithm>
#include <iostream>
#include <list>
using namespace std;

template <class T>
void copy(T* first, T* last, T* target) {
  cout << "This is our own copy" << endl;
  for(; first != last; ++first, ++target) {
    *target = *first;
  }
  cout << "end" << endl;
}


int main() {
  char a[] = "barfoo";
  char b[sizeof(a)];

  copy(a, &a[sizeof(a)+1], b);
  cout << b << endl;


  // Långt net i koden...

  list<char> mylist;
  list<char> myresult;
  mylist.push_back('b');
  mylist.push_back('a');
  mylist.push_back('r');

  copy(mylist.rbegin(), mylist.rend(), myresult.rbegin());
  

  return 0;
}
