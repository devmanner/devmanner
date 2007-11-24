/*
 * applex/2/c/symbol.h
 */

#define PLUS       257
#define MINUS      258
#define TIMES      259
#define DIVIDE     260
#define POWER      261
#define LEFTPAREN  262
#define RIGHTPAREN 263
#define EQUALS     264
#define NEWLINE    265
#define LET        266
#define NUMBER     267
#define VARIABLE   268
#define UNKNOWN    269

typedef union
{
  double num;
  const char *var;
  char ch;
} YYSTYPE;

extern YYSTYPE yylval;
