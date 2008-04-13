#include <deque>
#include <iostream>
#include <algorithm>
#include <iterator>


using namespace std;

int main() {
  deque<int> d;
  d.resize(5);
  d[0] = 1;
  d[1] = 2;
  d[2] = 3;
  d[3] = 4;
  d[4] = 5;

  for(deque<int>::iterator itr = d.begin(); itr != d.end(); ++itr)
    cout << *itr << endl;

  d.push_back(10);
  d.push_back(20);
  d.push_back(30);
  d.push_back(40);
  d.push_back(50);

  cout << d[0] << endl;

  copy(d.begin(), d.end(), ostream_iterator<int>(cout, " "));
  cout << endl;

}
