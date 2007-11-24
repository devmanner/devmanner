#include <set>
#include <vector>
#include <algorithm>
#include <iterator>
#include <iostream>
#include <cstdio>
#include <cassert>

template <typename T>
void dump(const T &x) {
  std::copy(x.begin(), x.end(), std::ostream_iterator<typename T::value_type>(std::cout, " "));
  std::cout << std::endl;
}

void read_til(char endc) {
  char c;
  do {
    c = getchar();
  } while (c != endc);
}

char next_token() {
  char c;
  do {
    c = getchar();
  } while (c == ' ' || c == '\n' || c == '\t');
  return c;
}

std::set<int> sums;
#ifdef DBG
std::vector<int> visited;
#endif

/*
  A tree looks like:
  ()
  (X tree tree)
*/
// Returns the number if children of the child.
int sum_child(int parent_sum) {
  int x;
  switch(next_token()) {
  case '(':
    if (scanf("%d", &x) == 1) {
#ifdef DBG
      visited.push_back(x);
#endif
      int nchild = sum_child(x + parent_sum) + sum_child(x + parent_sum);
      
      char c = next_token();
      //printf("1:c %c\n", c);
      assert(c == ')');
      
      if (nchild == 0) {
	//printf("%d has no children\n", x);
	sums.insert(parent_sum + x);
      }
      return 1+nchild;
    }
    else {
      char c = next_token();
      //printf("2:c %c\n", c);
      assert(c == ')');
      return 0;
    }
    break;
  case ')':
    assert( 0 && "Dont think this will happen...\n");
    break;
  }
  return 0;
}

bool check_sum(int sum_to_get) {
  sums.clear();
#ifdef DBG
  visited.clear();
#endif

  sum_child(0);

#ifdef DBG
  dump(sums);
  dump(visited);
#endif

  return sums.find(sum_to_get) != sums.end();
}
 
int main() {
  int sum;
  while (scanf("%d", &sum) == 1)
    printf("%s\n", (check_sum(sum) ? "yes" : "no"));
  return 0;
}
