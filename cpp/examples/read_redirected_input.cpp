#include <iostream>
#include <string>
#include <iterator>
#include <algorithm>
#include <vector>

using namespace std;

int main() {
  vector<int> input;
  copy(istream_iterator<int>(cin), istream_iterator<int>(), back_inserter(input));

  int Xsize = input[0];
  int Ysize = input[1];
  int edges = input[2];

  cout << "Xsize: " << Xsize << " Ysize: " << Ysize << " Edges: " << edges << endl;

  for (size_t index = 3; index < input.size(); index += 2)
    cout << input[index] << " " << input[index+1] << endl;

  /*
  istream_iterator<int> input(cin), eof;
  int Xsize, Ysize;
  input >> Xsize;
  input >> Ysize;

  while (input != eof) {
    int x, y;
    input >> x;
    input >> y;
    cout << "X: " << x << " Y: " << y << endl;
  }
  */

  /*
  int x, y;
  cin.getline(x, 10);
  cin.getline(y, 10);

  cout << "X: " << x << " Y: " << y << endl;

  char buff[100];
  while(cin.getline(buff, 100)) {
    cout << "Read: " << buff << endl;
    
    }*/
  return 0;
}
