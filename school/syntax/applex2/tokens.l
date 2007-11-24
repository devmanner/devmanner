/*
 * applex/2/c/tokens.l
 *
 * Komplettera scannern med lämpliga regler.
 */

%{
#include "symbol.h"
%}

%%

[ \t]           ;
.               { yylval.ch = *yytext; return UNKNOWN; }

%%
