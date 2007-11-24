%{
/*
 * Denna rad gör att symboliska namn definieras för alla slutsymboler
 * som deklarerats i Bison-filen.
 *
 * I vårt fall innebär det att konstanten LETTER definieras.
 */
#include <stdio.h>
#include "parser.tab.h"
#define YYSTYPE union stype
%}

/* Stoppa in Flex-reglerna här. */
%%
        
[a-zA-Z]  { yylval.letter = *yytext; return LETTER; }
\|        { yylval.letter = *yytext; return OR; }
\(        { yylval.letter = *yytext; return LPAR; }
\)        { yylval.letter = *yytext; return RPAR; }
\*        { yylval.letter = *yytext; return TIMES; }
\n\ \t    { }

%%
