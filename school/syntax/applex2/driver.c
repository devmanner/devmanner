#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include "symbol.h"

YYSTYPE yylval;

int main()
{
  extern int yylex(void);
  int token;
  while((token = yylex()) != 0) {
    switch(token) {
    case PLUS:       printf("PLUS ");                         break;
    case MINUS:      printf("MINUS ");                        break;
    case TIMES:      printf("TIMES ");                        break;
    case DIVIDE:     printf("DIVIDE ");                       break;
    case POWER:      printf("POWER ");                        break;
    case LEFTPAREN:  printf("LEFTPAREN ");                    break;
    case RIGHTPAREN: printf("RIGHTPAREN ");                   break;
    case EQUALS:     printf("EQUALS ");                       break;
    case NEWLINE:    printf("NEWLINE\n");                     break;
    case LET:        printf("LET ");                          break;
    case NUMBER:     printf("NUMBER<%f> ", yylval.num);       break;
    case VARIABLE:   printf("VARIABLE<%s> ", yylval.var);     break;
    default:         printf("[Lexikalt fel! Läste %c] ", yylval.ch);
    }
  }
  printf("\n");
  return EXIT_SUCCESS;
}
