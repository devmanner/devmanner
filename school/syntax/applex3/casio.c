/*
 * En räknedosa som klarar räknesätten + - * / och ^.
 * Syntaxanalysen görs med rekursiv medåkning (recursive descent).
 *
 * Grammatik utan vänsterrekursion:
 *
 *    <start> ::= epsilon
 *             |  NEWLINE <start>
 *             |  <expr> NEWLINE <start>
 *
 *    <expr>  ::= <term> <expr1>
 *
 *    <expr1> ::= PLUS <term> <expr1>
 *             |  MINUS <term> <expr1>
 *             |  epsilon
 *
 *    <term>  ::= <factor> <term1> 
 *       
 *    <term1> ::= TIMES <factor> <term1>
 *             |  DIVIDE <factor> <term1>
 *             |  epsilon
 *
 *    <factor>::= <prim> <factor1>
 *         
 *    <factor1>::= epsilon | POWER <factor>
 *         
 *    <prim>  ::= NUMBER
 *             |  MINUS <prim>
 *             |  LEFTPAREN <expr> RIGHTPAREN
 *
 */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <string.h>
#include "lexer.h"


/* Structure for holding variable names. */
struct VarNameMap {
  static int cnt;
  char *name;
  double value;
};
VarNameMap varMap[256];
int VarNameMap::cnt = 0;  



/*
 *  Anropas för att få spårutskrifter
 */
static void Debug(char *s)
{
#ifdef DEBUG
  fprintf(stderr, "%s\n", s);
#endif
}


/* expr() och factor() anropas innan den definieras */
double expr();
double factor();


double error(char *s) 
{
  fprintf(stderr, "\t%s\n\n\tKastar bort resten av raden...\n\n", s);
  while(peekToken() != 0 && peekToken() != NEWLINE)
    nextToken();
  return 0.0;
}



/*  Nu följer funktioner som svarar mot icke-slutsymboler i grammatiken. 
 *  De returnerar värdet av det deluttryck de reducerar.
 */


/*
 * prim --> NUMBER | LEFTPAREN expr RIGHTPAREN | MINUS prim
 */
double prim()
{
  double val;
  
  Debug("prim-->");
  
  switch(peekToken()) {
  /* FIRST(NUMBER) */
  case NUMBER:
    nextToken();
    return tokenValue().num;
  /* FIRST(LEFTPAREN expr RIGHTPAREN) */
  case LEFTPAREN:
    nextToken();
    val = expr();
    if(peekToken() == RIGHTPAREN) {
      nextToken();
      return val;
    }
    else {
      error("Högerparentes saknas");
      return 1.0;
    }
  /* FIRST(MINUS prim) */
  case MINUS:
    nextToken();
    return -prim();
  default:
    error("Prim: borde vara LEFTPAREN, NUMBER eller RIGHTPAREN");
    return 1.0;
  }
}


/*
 *  factor1 --> epsilon | '^' factor
 */
double factor1() 
{
  Debug("factor1-->");
  switch(peekToken()) {
  /* FIRST(POWER factor) */
  case POWER:
    nextToken();
    return factor();
  /* FOLLOW(factor1)  */
  case RIGHTPAREN:
  case PLUS:
  case MINUS:
  case TIMES:
  case DIVIDE:
  case NEWLINE:
    return 1;  /* term1 --> epsilon */
  default:  
    return error("Factor1: borde vara radslut, ), +, -, *, / eller ^");
  }
}



/*
 *  factor --> prim factor1
 */
double factor() 
{
  double pval;
  
  Debug("factor-->");
  switch(peekToken()) {
  /* FIRST(factor term1) */
  case NUMBER:
  case MINUS:
  case LEFTPAREN:
    pval = prim();
    return pow(pval, factor1());
  default:
    error("Felaktigt uttryck.");
    return 0.0;
  }
}



/*
 * term1 --> TIMES factor term1 | DIVIDE factor term1 | epsilon
 *
 * Parametern acc behövs eftersom * och / är vänsterassociativa.
 * En terms värde ackumuleras i acc.
 */
double term1(double acc) 
{
  double fval;

  Debug("term1-->");

  switch(peekToken()) {
  /* FIRST(TIMES factor term1) */
  case TIMES:
    nextToken();
    fval = factor();
    return term1(acc * fval);
  /* FIRST(DIVIDE factor term1) */
  case DIVIDE:
    nextToken();
    fval = factor();
    return term1(acc / fval);
  /* titta på FOLLOW( term1 )  */
  case NEWLINE:
  case RIGHTPAREN:
  case PLUS:
  case MINUS:
    return acc;  /*  term1 --> epsilon  */
  default:
    return error("Term1: borde vara ), radslut, +, -, * eller /");
  }
}


/* 
 * term --> factor term1
 */
double term()
{
  double fval;
  Debug("term-->");
  switch(peekToken()) {
  /* FIRST(factor term1) */
  case NUMBER:
  case MINUS:
  case LEFTPAREN:
    fval = factor();
    return term1(fval);
  default:
    error("Felaktigt uttryck.");
    return 0.0;
  }
}


/*
 *  expr1 --> PLUS term expr1 | MINUS term expr1 | epsilon
 *
 * Parametern acc behövs eftersom + och - är vänsterassociativa.
 * Ett uttrycks värde ackumuleras i acc.
 */
double expr1(double acc)
{
  double tval;
  
  Debug("expr1-->");

  switch(peekToken()) {
  /* FIRST(PLUS term expr1) */
  case PLUS:
    nextToken();
    tval = term();
    return expr1(acc + tval);    
  /* FIRST(MINUS term expr1) */
  case MINUS:
    nextToken();
    tval = term();
    return expr1(acc - tval);
  /* FOLLOW(expr1) */
  case RIGHTPAREN:
  case NEWLINE:
    return acc;  /*  expr1 --> epsilon  */
  default:
    return error("Expr1: borde vara +, -, ) eller radslut");
  }
}


/*
 *  expr --> term expr1  
 */
double expr()
{
  double tval;
  Debug("expr-->");
  switch(peekToken()) {
  /* FIRST(term expr1) */
  case NUMBER:
  case MINUS:
  case LEFTPAREN:
    tval = term();
    return expr1(tval);
  default:
    error("Felaktigt uttryck.");
    return 0.0;
  }
}

char* variable(void) {
  char *p;
  assert(p = (char*) malloc(sizeof(char) * (strlen(yylval.var)+1)));
  strcpy(p, yylval.var);
  return p;
}

/*
 *  start -->   epsilon
 *            | NEWLINE start
 *            | expr NEWLINE start 
 */
void start() 
{
  double eval;
  char *var_name;
  
  switch(peekToken()) {
  /* FIRST(NEWLINE start) */
  case NEWLINE:
    nextToken();
    start();
    break;
  /* FIRST(expr NEWLINE start) */
  case NUMBER:
  case MINUS:
  case LEFTPAREN:
    eval = expr();
    if(peekToken() != NEWLINE) {
      error("Radslut förväntades.");
      /* error() kastar bort slutsymboler tills peekToken() == NEWLINE */
    }
    printf("%f\n", eval);
    nextToken();
    start();
    break;
  /* FOLLOW(start) */
  case 0:
    break;
  case LET:
    nextToken();
    var_name = variable();
    nextToken();
    if (peekToken() != EQUALS) {
        free(var_name);
        error("= förväntades");
    }
    nextToken();

    varMap[VarNameMap::cnt].name = var_name;
    /* Vi räknar kallt med att expr inte innehåller variabler, så kan man inte gööra. */
    varMap[VarNameMap::cnt++].value = expr();
    printf("Set %s to %.2f\n", varMap[VarNameMap::cnt-1].name, varMap[VarNameMap::cnt-1].value);
    start();
    
    break;
  default:
    error("Felaktigt uttryck.");
    /* error() kastar bort slutsymboler tills peekToken() == NEWLINE */
    start();
    break;
  }
}

int main()
{
  initLexer();
  start();
  return 0;
}
