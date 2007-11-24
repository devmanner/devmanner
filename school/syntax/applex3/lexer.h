#include <stdio.h>
#include "symbol.h"


/*
 * Initierar den lexikala analysatorn.
 */
void initLexer(void);


/* 
 * Tjuvtittar p� n�sta slutsymbol och returnerar den.
 */
int peekToken();


/* 
 * L�ser in en ny slutsymbol och returnerar den.
 * Ifall det inte finns fler slutsymboler att l�sa returneras 0.
 */
int nextToken();


/*
 * V�rdet p� den slutsymbol som l�stes vid det senaste anropet
 * av nextToken().
 */
YYSTYPE tokenValue();
