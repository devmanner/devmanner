#include <strings.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define BASE 1000
#define SIZE 1024
#define UNDEF -1

#define MAX_IN 366

int freq[MAX_IN+1][10];

void calc_freq(void) {
  unsigned num[SIZE] = {0};
  int x, i, j;

  for (i = 0; i < MAX_IN+1; ++i)
    for (j = 0; j < 10; ++j)
      freq[i][j] = 0;

  /* 0! */
  freq[0][1] = 1;
  /* 1! */
  freq[1][1] = 1;
  /* 2! */
  freq[2][2] = 1;
  num[0] = 2;
  
  for (x = 3; x <= MAX_IN; ++x) {
    int carry = 0;
    int last;
    /* Calculate x! depending on (x-1)! */
    for (i = 0; i < SIZE; ++i) {
      num[i] = num[i] * x + carry;
      carry = 0;
      if (num[i] > BASE) {
	carry = num[i] / BASE;
	num[i] = num[i] % BASE;
      }
    }
    /*
    if (x < 100) {
      printf("%d\n", x);
      for (i = 100; i != -1; --i)
	printf("%d", num[i]);
      printf("\n\n");
      }*/
	   
    /* Find the first != 0 from behind. */
    
    for (i = SIZE-1; i != -1; --i)
      if (num[i]) {
	last = i;
	break;
      }

    /* Count frequency */
    for (i = 0; i <= last; ++i) {
      /* Thease are hard coded for base 1000. */ 
      if (num[i] == 0) {
	freq[x][0] += 3;
	continue;
      }
      if (num[i] < 10 && i != last)
	freq[x][0] += 2;
      else if (num[i] < 100 && i != last)
	freq[x][0]++;

      j = num[i];
      for (; j; j /= 10)
	++freq[x][j % 10];

    }
  }
}


int main() {
  int x;

  calc_freq();

  while (scanf("%d", &x) != EOF && x) {
    int i;
    printf("%d! --\n", x);
    for (i = 0; i < 10; ++i) {
      if (!(i % 5))
	putchar('\n');
      printf("\t(%d)\t%d", i, freq[x][i]);
     }
    putchar('\n');    
  }
  return 0;
}
