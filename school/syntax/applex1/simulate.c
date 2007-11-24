#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "nfasim.h"


/*
11
#  4 -1 0
A  2 -1 0
#  3  1 0
B  7 -1 0
#  5  2 0
A  6 -1 0
C  7 -1 0
#  8 -1 0
D  9 -1 0
# 10 -1 0
# -1 -1 1

Motsvarar: (A*B|AC)D
*/

int main(int argc, char **argv)
{
    FILE *infil;
    char line[80];
    const char *eol;
    size_t numstates;
    transition_t *transitions;
    int *accept;
    char *nyrad;
    unsigned int i;

    if(argc != 2 || (infil = fopen(argv[1],"r")) == NULL)
    {
        fprintf(stderr, "Användning: %s filnamn\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    /* Läs in automaten, förutsätt korrekt datafil. */
    fgets(line, 80, infil);
    sscanf(line, "%d", &numstates);
    assert((transitions = malloc(numstates * sizeof (*transitions))) != NULL);
    assert((accept = malloc(numstates * sizeof (*accept))) != NULL);
    for(i = 0; i < numstates; i++)
    {
        fgets(line, 80, infil);
        transitions[i].symbol = line[0];
        sscanf(line + 2, "%d%d%d",
               &(transitions[i].left),  &(transitions[i].right), accept+i);
    }
    /* Läs in strängen automaten ska läsa. */
    printf("Ange automatens indata: ");
    fgets(line, 80, stdin);
    nyrad = strchr(line, '\n');
    if(nyrad == NULL)
    {
        fprintf(stderr, "För lång rad!\n");
        exit(EXIT_FAILURE);
    }
    else
    {
        *nyrad = '\0';
        if(simulate(accept, transitions, numstates, line, &eol))
            printf("Automaten accepterar %s strängen.\n",
                   *eol == '\0' ? "hela" : "del av");
        else
            printf("Automaten accepterar ej.\n");
    }
	
	free(transitions);
	free(accept);
    return EXIT_SUCCESS;
}
