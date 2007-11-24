#include <stdio.h>
#include "symbol.h"


/*
 * Initierar den lexikala analysatorn.
 */
void initLexer(void);


/* 
 * Tjuvtittar på nästa slutsymbol och returnerar den.
 */
int peekToken();


/* 
 * Läser in en ny slutsymbol och returnerar den.
 * Ifall det inte finns fler slutsymboler att läsa returneras 0.
 */
int nextToken();


/*
 * Värdet på den slutsymbol som lästes vid det senaste anropet
 * av nextToken().
 */
YYSTYPE tokenValue();
