#include <stdio.h>
#include <string.h>
#include <assert.h>

#define SIZE 5000

int main() {
  int t; /* Täljare */
  int n; /* Nämnare */
  int rests[SIZE];
  int cycle[SIZE];

  while (scanf("%d %d", &t, &n) != EOF) {
    int len = -1, cstart = -1;
    int rest = t;
    int i = 0;

    assert(n && "nämnare == 0");
    memset(rests, 0, SIZE*sizeof(int));
    memset(cycle, 0, SIZE*sizeof(int));

    i = 0;
    do {
      cycle[i] = (rest / n);
      rest = rest % n;

#ifdef DBG
      printf("num: %d rest: %d\n", cycle[i], rest);
#endif 

      if (rests[rest] && cycle[rests[rest]] == cycle[i]) {
	len = (i - rests[rest]);
	cstart = rests[rest];

	/* Add the last digit */
	rest *= 10;
	cycle[++i] = (rest / n);
	break;
      }

      rests[rest] = i;
      
      rest *= 10;
      ++i;
    } while (i < SIZE); 

    assert(cstart != -1 && len != -1 && "len & cstart not defined");

    printf("%d/%d = %d.", t, n, cycle[0]);
    for (i = 1; i < cstart; ++i)
      printf("%d", cycle[i]);
    printf("(");
    for (i = cstart; i < len+cstart; ++i) {
      if (i > 50) {
	printf("...");
	break;
      }
      printf("%d", cycle[i]);
    }
    
    printf(")\n %d = number of digits in repeating cycle\n", len);
  }

  return 0;
}
