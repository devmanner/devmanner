#include <iostream>

using namespace std;

int main() {
  char **ar;
  ar = new char*[20];
  for (int i = 0; i < 20; ++i)
    ar[i] = new char[20];

  for (int j = 0; j < 20; ++j)
    for (int i = 0; i < 20; ++i)
      ar[j][i] = (char)i+65;

  for (int j = 0; j < 20; ++j) {
    for (int i = 0; i < 20; ++i)
      cout << ar[j][i] << " ";
    cout << endl;
  }

  for (int i = 0; i < 20; ++i)
    delete [] ar[i];
  delete [] ar;
}
