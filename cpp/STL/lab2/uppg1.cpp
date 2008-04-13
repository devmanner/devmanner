#include <numeric>
#include <algorithm>
#include <iostream>
#include <list>
#include <iterator>
#include <stdlib.h>

using namespace std;

void mb10(double &d) {
  d *= 10.0;
}

bool isMinus(double d) {
  return d < 0;
}


int main() {
  list<double> dl;

  srand(time(NULL));

  for (int i = 0; i < 10; ++i)
    dl.push_back(rand()%11 - 5);

  cout << "Original:" << endl;
  copy(dl.begin(), dl.end(), ostream_iterator<double>(cout, " "));
  cout << endl;

  cout << "Mult by 10:" << endl;
  for_each(dl.begin(), dl.end(), mb10);
  copy(dl.begin(), dl.end(), ostream_iterator<double>(cout, " "));
  cout << endl;

  cout << "< 0:" << endl;
  for (list<double>::iterator itr = dl.begin();
       itr != dl.end(); itr = find_if(++itr, dl.end(), isMinus))
    cout << *itr << endl;

  cout << "Sum is: " << accumulate(dl.begin(), dl.end(), 0.0) << endl;

}
