#include <stdio.h>
#include "symbol.h"

extern int yylex(void);
YYSTYPE yylval;
static int next = 0;     /* Vi behöver kunna tjuvtitta på nästa symbol. */
static int current = 0;  /* Aktuell slutsymbol. */
static YYSTYPE value;    /* Värdet på aktuell slutsymbol. */


static void printToken(FILE *out, int token)
{
#ifdef DEBUG
  switch(token) {
  case PLUS:       fprintf(out, "PLUS ");                         break;
  case MINUS:      fprintf(out, "MINUS ");                        break;
  case TIMES:      fprintf(out, "TIMES ");                        break;
  case DIVIDE:     fprintf(out, "DIVIDE ");                       break;
  case POWER:      fprintf(out, "POWER ");                        break;
  case LEFTPAREN:  fprintf(out, "LEFTPAREN ");                    break;
  case RIGHTPAREN: fprintf(out, "RIGHTPAREN ");                   break;
  case EQUALS:     fprintf(out, "EQUALS ");                       break;
  case NEWLINE:    fprintf(out, "NEWLINE ");                      break;
  case LET:        fprintf(out, "LET ");                          break;
  case NUMBER:     fprintf(out, "NUMBER<%f> ", value.num);        break;
  case VARIABLE:   fprintf(out, "VARIABLE<%s> ", value.var);      break;
  case 0:          fprintf(out, "[End of input]");                break;
  default:         fprintf(out, "[Lexikalt fel! Läste %c] ", value.ch);
  }
#endif
}



void initLexer(void)
{
  next = yylex();
}



int peekToken()
{
#ifdef DEBUG
  fprintf(stderr, "\tpeekToken() == ");
  value = yylval;
  printToken(stderr, next);
  fprintf(stderr, "\n");
#endif
  return next;
}



int nextToken()
{
  current = next;
  if(next != 0) {
    value = yylval;
    next = yylex();
#ifdef DEBUG
    fprintf(stderr, "\tnextToken(): Reading new token ");
    printToken(stderr, current);
    fprintf(stderr, "\n");
#endif
  }
  else {
#ifdef DEBUG
    fprintf(stderr, "\tnextToken(): No more tokens to read!\n");
#endif
  }
  return current;
}



YYSTYPE tokenValue()
{
  return value;
}
