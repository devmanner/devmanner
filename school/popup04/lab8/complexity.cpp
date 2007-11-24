#include <vector>
#include <iterator>
#include <algorithm>
#include <iostream>
#include <string>
#include <cstdio>
#include <cstdlib>
#include <cassert>

void print();
void eval();

struct Term {
  //  char c;
  int x;
};

int coff;
int mult;
/* On index 0 the coefficient is 0. */
struct Term term[11];


void eval() {
  for (;;) {
    char num[16];
    char str[16];
    scanf("%s", str);
#ifdef DBG
    printf("read: %s", str);
#endif
    if (str[0] == 'L' || str[0] == 'O') {
      scanf("%s", num);
#ifdef DBG
      printf(" %s", num);
#endif
    }
#ifdef DBG
    printf("\n");
#endif

    switch(str[0]) {
    case 'L': // LOOP
      if (num[0] == 'n') {
	++coff;
	eval(); // A loop-body
	--coff;
      }
      else {
	//term[coff].x += coff*atoi(num);
	int old_mult = mult;
	mult *= atoi(num);
	eval(); // A loop-body
	mult = old_mult;
      }
      break;
    case 'O': // OP
      term[coff].x += atoi(num) * mult;
      //term[coff].c = 'n';
      break;
    case 'E': // END
      return;
      break;
    }
  }
}

void print() {
#ifdef DBG
  for (int i = sizeof(term) / sizeof(struct Term) - 1; i != -1; --i)
    printf("i: %d\tx: %d\n", i, term[i].x);
#endif
  std::vector<std::string> v;

  for (int i = sizeof(term) / sizeof(struct Term) - 1; i != -1; --i) {
    char s[16] = {0};
    if (!term[i].x)
      continue;
    if (term[i].x > 1) {
      sprintf(s + strlen(s), "%d", term[i].x);
      if (i)
	sprintf(s + strlen(s), "*n");
      if (i > 1)
	sprintf(s + strlen(s), "^%d", i);
    }
    else if (term[i].x == 1) {
      if (!i)
	sprintf(s + strlen(s), "1");
      if (i)
	sprintf(s + strlen(s), "n");
      if (i > 1)
	sprintf(s + strlen(s), "^%d", i);
    }
    v.push_back(s);
  }
  if (!v.empty()) {
    std::copy(v.begin(), v.end()-1, std::ostream_iterator<std::string>(std::cout, "+"));
    std::cout << v.back();
  }
  else
    printf("0");
  printf("\n");
}


int main() {
  int ntc;
  scanf("%d", &ntc);
  for (int tc = 1; tc <= ntc; ++tc) {
    for (size_t i = 0; i < sizeof(term) / sizeof(struct Term); ++i) {
      //      term[i].c = 0;
      term[i].x = 0;
    }
    // read BEGIN and treat it like LOOP 1
    scanf("%*s");
    coff = 0;
    mult = 1;
    
    eval();
    printf("Program #%d\nRuntime = ", tc);
    print();
    printf("\n");
  }
  return 0;
}
