#ifndef _NFA_H_
#define _NFA_H_

#include <stddef.h>

typedef struct state_ {
	char symbol;
	int left;
	int right;
	int accepting;
} state_t;

extern state_t *stateData;

extern const char EPSILON;

/*
 * Reserverar ett nytt tillst�nd. Detta tillst�nd kan sedan
 * initieras genom att indexera stateData, exempelvis med
 *
 *   stateData[i].symbol = EPSILON;
 *
 * F�rsta g�ngen newState() anropas returnerar den 0.
 */
int newState(void);

/*
 * Returnerar antal tillst�nd i automaten.
 */
int numStates(void);

/*
 * Returnerar ett av automatens tillst�nd.
 */
state_t *getState(size_t i);

#endif
