#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <ifstream>

using namespace std;

int main() {
  vector<string> input;
  ifstream in;
  in.read("namn.txt");

  copy(istream_iterator<string>(in), istream_iterator<int>(), back_inserter(input));
  copy(input.begin(), input.end(), ostream_iterator<string>(cout, " "));

  return 0;
}
