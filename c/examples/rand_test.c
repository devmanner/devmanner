#include <stdlib.h>
#include <time.h>
#include <stdio.h>

int main() {
  int i;
  float tal = 1.0, ptal;
  srand(time(NULL));
  for (i = 0; i < 10 ; i++) {
    ptal = tal;
    tal = ((rand() % 10) - 5) / 10.0;
    printf("Talet: %.1f\n", tal);
    if (tal < -2 || tal > 2) {
      printf("Error\n");
      break;
    }
  }
  return 0;
}
