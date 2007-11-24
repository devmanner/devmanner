#include <iostream>
#include <list>
#include <algorithm>
#include <iterator>
#include <cstdio>

using namespace std;

typedef list<int> stack_t;

bool isSorted(stack_t &s) {
  int tmp = *s.begin();
  stack_t::iterator itr = s.begin();
  for (++itr; itr != s.end(); ++itr) {
    if (*itr < tmp)
      return false;
    tmp = *itr;
  }
  return true;
}

int main() {
  stack_t stack;
  char line[2048];
  char *p_line;

  while(gets(line)) {
    int tmp;
    p_line = strtok(line, " ");
    while (p_line && sscanf(p_line, "%d", &tmp) == 1) {
      stack.push_back(tmp);
      p_line = strtok(NULL, " ");
    }

    /* Print the original stack. */
    /*printf("Stack: ");*/
    copy(stack.begin(), stack.end(), ostream_iterator<int>((cout), " "));
    printf("\n");


    /* Begin ordering the stack. */
    /* Smallest pancace on begin() and largest on end(). */
    stack_t::iterator sorted_til = stack.end();
    /*    while (sorted_til != stack.begin()) {*/
    while (!isSorted(stack)) {
      /* Bring the largest not yet sorted element to the top. */
      stack_t::iterator max = max_element(stack.begin(), sorted_til);

      /* Print the flip. */
      printf("%d ", distance(max, stack.end()));

      /* Inc by one for the reverse. */
      ++max;

      /* Flip up largest element (largest not sorted) to the top... */
      reverse(stack.begin(), max);

      /* ...and flip it down to its position. */
      reverse(stack.begin(), sorted_til);
      if (sorted_til == stack.end())
	printf("1 ");
      else
	printf("%d ", distance(sorted_til, stack.end()) + 1);

      --sorted_til;
    }

    printf("0\n");
    /*
    printf("Sorted: ");
    copy(stack.begin(), stack.end(), ostream_iterator<int>((cout), " "));
    printf("\n");    
    */

    stack.clear();
  }

  return 0;
}
