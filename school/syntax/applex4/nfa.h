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
 * Reserverar ett nytt tillstånd. Detta tillstånd kan sedan
 * initieras genom att indexera stateData, exempelvis med
 *
 *   stateData[i].symbol = EPSILON;
 *
 * Första gången newState() anropas returnerar den 0.
 */
int newState(void);

/*
 * Returnerar antal tillstånd i automaten.
 */
int numStates(void);

/*
 * Returnerar ett av automatens tillstånd.
 */
state_t *getState(size_t i);

#endif
