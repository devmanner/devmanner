#include <iostream>
#include <map>
#include <algorithm>
#include <iterator>
#include <set>
#include <string>
#include <cstdio>
#include <cctype>

using namespace std;

struct Key_t {
  Key_t(string w, int c) : word(w), cnt(c) {}
  Key_t(char *w, int c) : word(w), cnt(c) {}
  string word;
  int cnt;
};

typedef map<string, Key_t> map_t;
typedef set<string> set_t;

int main() {
  map_t words;
  char word[81];
  /* Parse the input and build words array. */
  while (scanf("%s", word)) {   
    if (!strcmp(word, "#"))     
      break;                    
    string sorted(word);
    for (string::iterator itr = sorted.begin(); itr != sorted.end(); ++itr)
      *itr = tolower(*itr);
    sort(sorted.begin(), sorted.end());

    /* Is the word in the wordlist? */
    map_t::iterator wi = words.find(sorted);
    if (wi != words.end())
      wi->second.cnt++;
    else
      words.insert(map_t::value_type(sorted, Key_t(word, 1)));
  }

  set_t anagrams;
  for (map_t::iterator itr = words.begin(); itr != words.end(); ++itr) {
    if (itr->second.cnt == 1)
      anagrams.insert(itr->second.word);
  }

  copy(anagrams.begin(), anagrams.end(), ostream_iterator<string>(cout, "\n"));

  return 0;
}
