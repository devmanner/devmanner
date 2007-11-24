%{
/*
 * Här kan man stoppa in C-kod som man vill ha först i den
 * C-fil som genereras av Bison.
 */
#include <stdio.h>
#include <assert.h>
#include "nfa.h"
int yylex(void);
int yyerror(char *);
void print_state(void);

//#define DEBUG

#ifdef DEBUG
#define dbg_printf printf
#else
#define dbg_printf
#endif

%}

/*
 * Detta deklarerar typen hos de semantiska värdena.
 * I vårt fall kan den typen antingen vara en bokstav eller
 * en struktur med två heltal i.
 */
%union stype{
    char letter;
    struct{
			int enter;
			int exit;
    } endstates;
}
%{
#define YYSTYPE union stype
%}

/*
 * För att Bison ska veta när den semantiska typen är en bokstav
 * och när den är en struktur, deklareras den semantiska typen hos
 * respektive slutsymboler och icke-slutsymboler nedan. Namnet inom
 * <...> svarar mot respektive namn i %union-deklarationen.
 *
 * Dessa deklarationer gör också att man får typkontroll när man
 * kompilerar den C-fil som genereras av Bison.
 */
%start regexp
%token <letter> LETTER LPAR RPAR TIMES OR
%type <endstates> expression term factor

%%

/* Stoppa in resten av Bison-reglerna här. */
regexp:			{ assert(newState() == 0); }
            expression
            { dbg_printf("expression\n");
              stateData[0].left = $2.enter;
              stateData[$2.exit].accepting = 1;
            }
						;
expression:	term
            { $$.enter = $1.enter;
              $$.exit = $1.exit;
            }
						|	expression OR term
						{ int state = $$.enter = newState();
						  stateData[state].left = $1.enter;
						  stateData[state].right = $3.enter;
						  stateData[$1.exit].left = stateData[$3.exit].left = $$.exit = newState();
					    dbg_printf("expression | term\n");
            }
						;
term:				factor
            { $$.enter = $1.enter;
              $$.exit = $1.exit;
              dbg_printf("factor\n");
            }
						| term factor
            { $$.enter = $1.enter;
              $$.exit = $2.exit;
              stateData[$1.exit].left = $2.enter;
              dbg_printf("term factor\n");
            }
						;
factor:			LPAR expression RPAR
            { $$.enter = $2.enter;
              $$.exit = $2.exit;
              dbg_printf("(expression)\n");
            }
						| factor TIMES
            { int i = $$.enter = newState();
              int j = $$.exit = newState();
              stateData[i].left = $1.enter;
              stateData[i].right = j;
              stateData[$1.exit].left = i;
              dbg_printf("factor *\n");
            }
						| LETTER
            { int i = $$.enter = newState();
              int j = $$.exit = newState();
              stateData[i].symbol = $1;
              stateData[i].left = j;
              dbg_printf("LETTER\n");
            }
						;


/* Om ni får problem med felmeddelandet av typen

("parser.y", line xx) error: type clash (...) on default action

kan ni lägga in tomma semantiska åtgärder ({} alltså)
efter de regler det blir problem med.

*/

%%

int main(void)
{
  int i;
  if (yyparse()) {
    printf("Error in input!\n");
    return 0;
  }
  print_state();
  return 0;
}

void print_state(void) {
  int i;
  printf("%d\n", numStates());
  for (i = 0; i < numStates(); ++i) {
    printf("%c %d %d %d\n", stateData[i].symbol, stateData[i].left, stateData[i].right, stateData[i].accepting);
  }
}

/*
 * Denna procedur skriver ut felmeddelanden under syntaxanalysen.
 */
int yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
  return 0;
}
