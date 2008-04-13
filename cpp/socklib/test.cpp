#include <iostream>
#include <list>
#include <iterator>
#include <algorithm>


using namespace std;

template<typename InputIterator, typename OutputIterator>
void my_copy(InputIterator start, InputIterator end, OutputIterator target) {
  while (start != end) {
    cout << "iterating: " << *start << endl;
    *++target = *++start;
  }
}


int main() {
  list<int> l;
  list<int> l2;
  insert_iterator<list<int> > itr(l, l.end());
  for (int i=1; i < 6; ++i) {
    *itr++ = i;
    //*(l.end()) = i;
    //l.push_back(i);
  }

  cout << "l: ";
  copy(l.begin(), l.end(), ostream_iterator<int>(cout, " "));
  cout << endl;


  my_copy(l.begin(), l.end(), back_inserter(l2));

  cout << "l2: ";
  copy(l2.begin(), l2.end(), ostream_iterator<int>(cout, " "));
  cout << endl;

  return 0;
}
