#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

#define MAX (300*20)

unsigned long long A[MAX+1][11];

/*
  The coins are:
  100, 50, 20, 10, 5, 2, 1, .5, .2, .1, .05
*/

int value[] = {0, 1, 2, 4, 10, 20, 40, 100, 200, 400, 1000, 2000};
#define VALUE_SIZE (sizeof(value) / sizeof(value[0]))


int main () {
  float amount;
  int i, j;

  for(i = 0; i < VALUE_SIZE; i++)
    A[0][i] = 1;
  for(i = 0; i < MAX+1; i++)
    A[i][1] = 1;
  
  for(i = 1; i < MAX+1; i++) {
    for(j = 2; j < VALUE_SIZE; j++) {
      if(i - value[j] < 0)
	A[i][j] = A[i][j-1];
      else
	A[i][j] = A[i][j-1] + A[i - value[j]][j];
    }
  }
  
  while(scanf("%f", &amount) != EOF) {
    if(amount == 0.00)
      break;
    printf("%6.2f%17llu\n", amount, A[(int)(amount * 20.0 + 0.5)][11]);
  }
  
  return 0;		
}
