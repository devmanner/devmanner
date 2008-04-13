#include <queue>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <string>
#include <set>
#include <stdlib.h>

using namespace std;

typedef priority_queue<pair<string, int>, vector<pair<string, int> > > q_type;

int main() {
  string s[] = {"kalle", "lisa", "pelle", "olle", "olof"};
  q_type q;
  srand(time(NULL));

  for (int i = 0; i < 5; ++i)
    q.push(q_type::value_type(s[i], rand()%10+1));

  while (!q.empty()) {
    cout << q.top().first << " -> " << q.top().second << endl;
    q.pop();
  }
}
