#include <algorithm>
#include <iostream>
#include <vector>
#include <iterator>
#include <stdlib.h>
#include <math.h>

using namespace std;

class condPow {
private:
  int min;
public:
  condPow(int m) : min(m) {}
  void operator()(int &x) {
    if (!(x%2))
      x = (int)pow((double)x, (double)min);
  }
};

int main() {
  vector<int> v;

  srand(time(NULL));
  for (int i = 0; i < 10; ++i)
    v.push_back(rand()%11+2);

  cout << "Before:" << endl;
  copy(v.begin(), v.end(), ostream_iterator<int>(cout, " "));

  //condPow cp();
  for_each(v.begin(), v.end(), condPow(*min_element(v.begin(), v.end())));
  cout << endl << "After:" << endl;
  copy(v.begin(), v.end(), ostream_iterator<int>(cout, " "));
  cout << endl;
}
