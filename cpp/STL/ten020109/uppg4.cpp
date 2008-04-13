#include <list>
#include <algorithm>
#include <math.h>
#include <stdlib.h>

int least;

bool even(int x ) { return !(x%2); }

void condPower(int &x) {
  if (even(x))
    x = (int)pow(x, least);
}

int main() {
  list<int> l;
  srand(time(NULL));

  for (int i = 0; i < 5; ++i)
    l.push_back(rand()%10+1);

  for(list<int>::iterator itr = l.begin(); itr != l.end(); ++itr)
    cout << *itr << endl;
  cout << "After:" << endl;

  least = *min_element(l.begin(), l.end());
  for_each(l.begin(), l.end(), condPower);


  for(list<int>::iterator itr = l.begin(); itr != l.end(); ++itr)
    cout << *itr << endl;

}
