/*
 * applex/2/c/tokens.l
 *
 * Komplettera scannern med l�mpliga regler.
 */

%{
#include "symbol.h"
%}

%%

[ \t]           ;
.               { yylval.ch = *yytext; return UNKNOWN; }

%%
