#ifndef _NFASIM_H_
#define _NFASIM_H_
#include "intset.h"
#include <stdlib.h>

/*
 * Datatyp för övergångsrelationen.
 *
 * symbol - anger vilket tecken som läses under övergången.
 *          '#' anger en epsilon-övergång.
 * left   - anger vilket tillstånd automaten ska gå till.
 *          Om left==-1 innebär detta att automaten inte
 *          ska gå till något tillständ.
 * right  - används endast vid epsilon-övergångar. Ifall
 *          automaten ska göra ett icke-deterministiskt
 *          val anges ett tillståndsnummer här, annars
 *          är right==-1.
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
 *   accept      - Mängden av accepterande tillstånd.
 *   transitions - En vektor av övergångar.
 *   numstates   - Antal positioner i vektorerna accept och transitions.
 *   string      - Pekare till en sträng som innehåller indata.
 *
 * UTDATA:
 *   pend        - Kommer att peka på de första olästa
 *                 tecknet då funktionen returnerar.
 *   returvärdet - 1 om automaten accepterat indata, 0 annars.
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