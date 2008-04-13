#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <iterator>
#include <set>

using namespace std;

int main() {
  string word;
  cout << "Enter a word: ";
  cin >> word;

  ifstream infile("diction.txt");
  istream_iterator<string> itr(infile), end;
  if (itr == end) {
    cout << "File not found." << endl;
    exit(1);
  }

  set<string> dict;
  while (itr != end) {
    dict.insert(*itr);
    ++itr;
  }

  sort(word.begin(), word.end());

  do {
    if (dict.find(word) != dict.end())
      cout << word << endl;
  } while (next_permutation(word.begin(), word.end()));
}
