#include <iostream>
#include <vector>
#include <algorithm>
#include <stdlib.h>

using namespace std;

int main() {
  vector<vector<int> > v(5, 6);
  srand(time(NULL));

  for (int i = 0; i < 5; ++i)
    for (int j = 0; j < 6; ++j)
      v[i][j] = rand() % 10;

  for (int i = 0; i < 5; ++i, cout << endl)
    for (int j = 0; j < 6; ++j)
      cout << v[i][j] << " ";

  cout << *(*v.begin()).begin() << endl;
}
