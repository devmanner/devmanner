#include "classes.hpp"

#include <cstdio>
#include <vector>

int main() {
  cBathroom b;
  typedef std::vector<cPerson*> vec_t;
  vec_t v;
  const int n_pers = 7;

  cRandomGenerator::get_instance().spawn();

  for (int i = 0; i < n_pers; ++i) {
    v.push_back(new cPerson(cPerson::FEMALE, &b));
    v.back()->spawn();
    v.push_back(new cPerson(cPerson::MALE, &b));
    v.back()->spawn();
  }

  scanf("%*s");

  for (vec_t::iterator itr = v.begin(); itr != v.end(); ++itr) {
    (*itr)->kill();
    (*itr)->wait();
    delete *itr;
  }
  
  return 0;
}

