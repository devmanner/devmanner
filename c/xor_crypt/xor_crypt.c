#include <stdio.h>
#include <ctype.h>
#include <string.h>

//#define KEY "Larry"
#define KEY "gay"


int main() {
  int oc, nc;
  int i = 0;
  while ((oc = getchar()) != EOF) {
    nc = oc ^ KEY[i++ % strlen(KEY)];
    /* Put oc unless nc is a controlchar */
    putchar((iscntrl(oc) || iscntrl(nc)) ? oc : nc);
  }
  return 0;
}
