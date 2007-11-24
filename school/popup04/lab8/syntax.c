#include <stdio.h>
#include <string.h>

/*
  0.
  The only characters in the language are the characters p through z and N, C, D, E, and I.
  1.
  Every character from p through z is a correct sentence.
  2.
  If s is a correct sentence, then so is Ns.
  3.
  If s and t are correct sentences, then so are Cst, Dst, Est and Ist.
  4.
  Rules 0. to 3. are the only rules to determine the syntactical correctness of a sentence.
*/

int is_sentence(char **p) {
  switch (**p) {
  case '\0':
    return 0;
    break;
  case 'C':
  case 'D':
  case 'E':
  case 'I':
    return ++(*p) && is_sentence(p) && ++(*p) && is_sentence(p);
    break;
  case 'N':
  case ' ':
    return ++(*p) && is_sentence(p);
  case 'p':
  case 'q':
  case 'r':
  case 's':
  case 't':
  case 'u':
  case 'v':
  case 'w':
  case 'x':
  case 'y':
  case 'z':
    return 1;
    break;
  }
  return 0;
}

int main() {
  char buff[300];
  char *p;
  while ( (p = gets(buff)) )
    printf("%s\n", (is_sentence(&p) && ++p) && (*p == '\0' || *p == '\n' || *p == ' ') ? "YES" : "NO");
  return 0;
}
