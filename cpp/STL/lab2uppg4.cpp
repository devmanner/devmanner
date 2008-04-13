#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <set>
using namespace std;

bool isEqual(string &s1, string &s2) {
	return (s1 == s2);
}

int main() {
  ifstream file("diction.txt");
  istream_iterator<string, char> file_itr(file), end;

  if(file_itr == end){
    cout << "error: file not found!";
    cin.get();
    exit(1);
  }

  // Put the file into a set
  set<string> words;
  for (; file_itr != end; ++file_itr)
    words.insert(*file_itr, words.end());
  exit(0);

  string word;
  cout << "Enter a word: ";
  cin >> word;
  
  sort(word.begin(), word.end());
  do {
    cout << "Testing: " << word << endl;
    if (find(file_itr, end, word) != end)
      cout << word << endl;
  } while (next_permutation(word.begin(), word.end()));
  
  cin.get();
  return 0;
}
