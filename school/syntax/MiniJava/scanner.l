%{
/*
 * Denna rad gör att symboliska namn definieras för alla slutsymboler
 * som deklarerats i Bison-filen.
 *
 * I vårt fall innebär det att konstanten LETTER definieras.
 */
#include <stdio.h>
#include <string.h>
#define YYSTYPE union stype
#include "parser.tab.h"

extern char g_identifierBuff[80];
extern int g_intLiteral;

//#define DEBUG
#ifdef DEBUG
#define dbg_printf printf
#else
#define dbg_printf(x, y)
#endif

%}

/* Stoppa in Flex-reglerna här. */
%%

boolean                 { dbg_printf("%s = BOOLEAN\n", yytext); return BOOLEAN; }
int                     { dbg_printf("%s = INT\n", yytext); return INT; }
void                    { dbg_printf("%s = VOID\n", yytext); return VOID; }
String                  { dbg_printf("%s = STRING\n", yytext); return STRING; }
class                   { dbg_printf("%s = CLASS\n", yytext); return CLASS; }
public                  { dbg_printf("%s = PUBLIC\n", yytext); return PUBLIC; }
static                  { dbg_printf("%s = STATIC\n", yytext); return STATIC; }
main                    { dbg_printf("%s = MAIN\n", yytext); return MAIN; }
if                      { dbg_printf("%s = IF\n", yytext); return IF; }
else                    { dbg_printf("%s = ELSE\n", yytext); return ELSE; }
while                   { dbg_printf("%s = WHILE\n", yytext); return WHILE; }
return                  { dbg_printf("%s = RETURN\n", yytext); return RETURN; }
System                  { dbg_printf("%s = SYSTEM\n", yytext); return SYSTEM; }
out                     { dbg_printf("%s = OUT\n", yytext); return OUT; }
println                 { dbg_printf("%s = PRINTLN\n", yytext); return PRINTLN; }
true                    { dbg_printf("%s = TRUE\n", yytext); return TRUE; }
false                   { dbg_printf("%s = FALSE\n", yytext); return FALSE; }
this                    { dbg_printf("%s = THIS\n", yytext); return THIS; }
new                     { dbg_printf("%s = NEW\n", yytext); return NEW; }
length                  { dbg_printf("%s = LENGTH\n", yytext); return LENGTH; }

\/\*(.|\n)*\*\/         { dbg_printf("Comment: %s\n", yytext); }
\(                      { dbg_printf("%s = LPAR\n", yytext); return LPAR; }
\)                      { dbg_printf("%s = RPAR\n", yytext); return RPAR; }
\{                      { dbg_printf("%s = LCURL\n", yytext); return LCURL; }
\}                      { dbg_printf("%s = RCURL\n", yytext); return RCURL; }
\[                      { dbg_printf("%s = LHPAR\n", yytext); return LHPAR; }
\]                      { dbg_printf("%s = RHPAR\n", yytext); return RHPAR; }
\;                      { dbg_printf("%s = SEMICOLON\n", yytext); return SEMICOLON; }
\,                      { dbg_printf("%s = COMMA\n", yytext); return COMMA; }
\.                      { dbg_printf("%s = DOT\n", yytext); return DOT; }
\!                      { dbg_printf("%s = NOT\n", yytext); return NOT; }
\=                      { dbg_printf("%s = ASSIGN\n", yytext); return ASSIGN; }

\&\&                    { dbg_printf("%s = AND\n", yytext); return AND; }
\<                      { dbg_printf("%s = LESS\n", yytext); return LESS; }
\+                      { dbg_printf("%s = PLUS\n", yytext); return PLUS; }
\-                      { dbg_printf("%s = MINUS\n", yytext); return MINUS; }
\*                      { dbg_printf("%s = TIMES\n", yytext); return TIMES; }


[0-9]+                  { dbg_printf("%s = INTEGER_LITERAL\n", yytext); g_intLiteral = atoi(yytext); return INTEGER_LITERAL; }

[a-zA-Z_]+[a-zA-Z0-9_]* { dbg_printf("%s = IDENTIFIER\n", yytext); strcpy(g_identifierBuff, yytext); return IDENTIFIER; }
\/\/.*\n                { dbg_printf("%s = // comment\n", yytext); }
\n\ \t                  { dbg_printf("%s = something\n", yytext); }

%%

