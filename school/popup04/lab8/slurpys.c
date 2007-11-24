#include <stdio.h>

int is_slump(char **p) {
  if (**p == 'D' || **p == 'E') {
    ++(*p);
    if (**p != 'F') {
      return 0;
    }
    while(**p == 'F') {
      ++(*p);
    }
    return (**p == 'G' && ++(*p)) || is_slump(p);
  }
  return 0;
}

int is_slimp(char **p) {
  if (**p == 'A') {
    ++(*p);
    if (**p == 'H')
      return 1 && ++(*p);
    if (**p == 'B') {
      ++(*p);
      return is_slimp(p) && **p == 'C' && ++(*p);
    }
    else
      return is_slump(p) && **p == 'C' && ++(*p);      
  }
  return 0;
}

int is_slurpy(char **p) {
  return is_slimp(p) && is_slump(p) &&
    (**p == '\n' || **p == '\0' || **p == ' ');
}

int main() {
  char buff[64];
  char *p;
  int ntc;
  scanf("%d", &ntc);
  printf("SLURPYS OUTPUT\n");
  gets(buff);
  while (ntc--) {
    p = gets(buff);
    printf("%s\n", (is_slurpy(&p)) ? "YES" : "NO");
  }
  printf("END OF OUTPUT\n");
  return 0;
}
