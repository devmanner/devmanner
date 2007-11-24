#include <assert.h>
#include <stdlib.h>
#include "nfa.h"

static int n_states = 0;
static int vecsize = 100;
state_t *stateData = NULL;
const char EPSILON = '#';

int newState() {
	if (stateData == NULL) {
		n_states = 0;
		vecsize = 2;
		stateData = malloc(vecsize * sizeof(*stateData));
		assert(stateData != NULL);
	}
	if (n_states >= vecsize) {
		vecsize *= 2;
		stateData = realloc(stateData, vecsize * sizeof(*stateData));
		assert(stateData != NULL);
	}
	stateData[n_states].symbol = EPSILON;
	stateData[n_states].left = -1;
	stateData[n_states].right = -1;
	stateData[n_states].accepting = 0;

	return n_states++;
}

int numStates() {
	return n_states;
}

state_t *getState(size_t i) {
	assert(i < n_states);
	return stateData + i;
}
