#include <string.h>
#include <stdio.h>
#include <assert.h>

int main() {
  char name[] = "Karl-Mikael Eriksson";
  char *fname = strtok(name, " ");
  char *lname = strtok(NULL, " ");
  assert(strtok(NULL, " ") == NULL);

  printf("fname: \t%s\nlname: \t%s\n", fname, lname);

  return 0;
}
