#include <vector.h>
#include <iostream.h>


int main() {
  vector<int> v1;
  for (int i=0; i < 10 ; i++)
    v1.push_back(i);

  vector<int>::iterator it = v1.begin();
  for (; it < v1.end(); ++it)
    cout << *it << endl;


  return 0;
}
