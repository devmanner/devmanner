/*
 * applex/2/c/tokens.l
 *
 * Komplettera scannern med lämpliga regler.
 */

%{
#include "symbol.h"
%}

%%

[ \t]			  ;
"("         { return LEFTPAREN; }
")"			    { return RIGHTPAREN; }
"^"	    		{ return POWER; }
"*"		    	{ return TIMES; }
"/"	  	 	  { return DIVIDE; }
"+" 			  { return PLUS; }
"-"			    { return MINUS; }
"="			    { return EQUALS; }
[0-9]+      { yylval.num = atof(yytext); return NUMBER; }
LET         { return LET; }
[a-z|A-Z]+  { yylval.var = yytext; return VARIABLE; }
"\n"	 	   	{ return NEWLINE; }
.			      { yylval.ch = *yytext; return UNKNOWN; }
%%
