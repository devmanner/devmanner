#include <algorithm>
#include <set>
#include <iterator>
#include <iostream>
#include <string>
#include <cstdio>

class Sorter {
public:
  /* Is c1 < than c2? */
  bool operator()(const std::string &_s1, const std::string &_s2) {
    const char *s1 = _s1.c_str();
    const char *s2 = _s2.c_str();
    while (*s1 == *s2) {
      ++s1;
      ++s2;
    }
    
    if (tolower(*s1) == tolower(*s2))
      return isupper(*s1);
    return (tolower(*s1) < tolower(*s2));
  }
};


int main() {
  typedef std::set<std::string, Sorter> cont_t;
  cont_t cont;
  
  int n_tc, len;
  char buff[1024];
  scanf("%d ", &n_tc);
  while (n_tc--) {
    fgets(buff, 1024, stdin);
    len = strlen(buff);
    std::sort(buff, buff+len-1);
    while (std::next_permutation(buff, buff+len-1))
      cont.insert(cont_t::value_type(buff));
    cont.insert(cont_t::value_type(buff));
    std::copy(cont.begin(), cont.end(), std::ostream_iterator<std::string>(std::cout, ""));
    cont.clear();
  }

  return 0;
}
