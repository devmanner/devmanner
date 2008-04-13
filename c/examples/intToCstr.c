#include <stdio.h>
#include <stdlib.h>


void getScoreStr(char *str, int playerScore) {
  sprintf(str, "Score: %d", playerScore);
}

int main() {
  char *s = malloc(sizeof(char)*10);
  getScoreStr(s, 10);
  printf("%s\n", s);
  free(s);
}

