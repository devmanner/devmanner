#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>

using namespace std;

int main() {
  vector<int> v;
  vector<int> res;

  for (int i = 0; i < 10; ++i)
    v.push_back(i);

  copy(v.begin(), v.end(), ostream_iterator<int>(cout, " "));
  cout << endl;

  vector<int>::iterator itr1 = v.begin(), itr2 = v.begin();
  for (++itr2; itr2 != v.end(); ++itr1, ++itr2) {
    res.clear();
    copy(v.begin(), itr1, back_inserter(res));
    copy(itr2+1, v.end(), back_inserter(res));
    
    copy(res.begin(), res.end(), ostream_iterator<int>(cout, " "));
    cout << endl;

  }


  return 0;
}
