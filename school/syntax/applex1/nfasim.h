#ifndef _NFASIM_H_
#define _NFASIM_H_
#include "intset.h"
#include <stdlib.h>

/*
 * Datatyp f�r �verg�ngsrelationen.
 *
 * symbol - anger vilket tecken som l�ses under �verg�ngen.
 *          '#' anger en epsilon-�verg�ng.
 * left   - anger vilket tillst�nd automaten ska g� till.
 *          Om left==-1 inneb�r detta att automaten inte
 *          ska g� till n�got tillst�nd.
 * right  - anv�nds endast vid epsilon-�verg�ngar. Ifall
 *          automaten ska g�ra ett icke-deterministiskt
 *          val anges ett tillst�ndsnummer h�r, annars
 *          �r right==-1.
 */
typedef struct transition_
{
    char symbol;
    int left, right;
} transition_t;

/*
 * Simulerar en NFA.
 *
 * INDATA:
 *
 *   accept      - M�ngden av accepterande tillst�nd.
 *   transitions - En vektor av �verg�ngar.
 *   numstates   - Antal positioner i vektorerna accept och transitions.
 *   string      - Pekare till en str�ng som inneh�ller indata.
 *
 * UTDATA:
 *   pend        - Kommer att peka p� de f�rsta ol�sta
 *                 tecknet d� funktionen returnerar.
 *   returv�rdet - 1 om automaten accepterat indata, 0 annars.
 */
int simulate(const int *accept,
             const transition_t *transitions,
             size_t numstates,
             const char *string,
             const char **pend);

static void epsilon_closure(int_set *set, const size_t numstates, const transition_t *transition);
/* Return true if the sets are disjunct. */
//static int is_disjunct(const int *accept, const int *set, size_t numstates);
static void set_transition(int_set *curr_set, const char c, const transition_t *transitions, size_t numstates, int_set *result);
//static is_empty(int *s, size_t size);

#endif