#include <iostream>

#define SIZE 20

unsigned long long int table[SIZE+1][SIZE+1];

using namespace std;

int main() {
  for (int i = 0; i <= SIZE; ++i) 
    for (int j = 0; j <= SIZE; ++j)
      table[i][j] = 1;

  for (int i = SIZE-1; i >= 0; --i) 
    for (int j = SIZE-1; j >= 0; --j) {
      //cout << i << " " << j << endl;
      table[i][j] = table[i+1][j] + table[i][j+1];
    }

  cout << table[0][0] << endl;

  system("PAUSE");
  return 0;
}
