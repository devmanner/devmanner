#include "nfasim.h"

static void epsilon_closure(int_set *set, const size_t numstates, const transition_t *transition) {
	int changed;
	do {
		unsigned int i;
		changed = 0;
		for (i = 0; i < numstates; ++i) {
			if (is_find(set, i)) {
				if (transition[i].symbol == '#') {
					if (transition[i].left != -1) {
						changed = (is_find(set, transition[i].left) == 0 || changed);
						is_insert(set, transition[i].left);
					}
					if (transition[i].right != -1) {
						changed = (is_find(set, transition[i].right) == 0 || changed);
						is_insert(set, transition[i].right);
					}
				}
			}
		}
	} while (changed == 1);
}

static void set_transition(int_set *curr_set, const char c, const transition_t *transitions, const size_t numstates, int_set *r) {
	int i;
	int_set result;
	is_init(&result, numstates);
	for (i = 0; i < numstates; ++i) {
		if (is_find(curr_set, i)) {
			if (transitions[i].symbol == c) {
				if (transitions[i].left != -1)
					is_insert(&result, transitions[i].left);
				if (transitions[i].right != -1)
					is_insert(&result, transitions[i].right);
			}
		}
	}
	is_destroy(r);
	*r = result;
}

int simulate(const int *accept, const transition_t *transitions, const size_t numstates, const char *string, const char **pend) {
	int i;
	int_set set, acc_set, tmp;

	is_init(&set, numstates);
	is_init(&acc_set, numstates);
	is_init(&tmp, numstates);

	for (i = 0; i < numstates; ++i)
		if (accept[i])
			is_insert(&acc_set, i);

	// Set q0 to active state.
	is_insert(&set, 0);
	epsilon_closure(&set, numstates, transitions);

	is_intersect(&set, &acc_set, &tmp);

	if (!is_empty(&tmp)) {
		is_destroy(&set);
		is_destroy(&acc_set);
		is_destroy(&tmp);
		*pend = string;
		return 1;
	}
	do {
		set_transition(&set, *string, transitions, numstates, &set);
		epsilon_closure(&set, numstates, transitions);
		is_intersect(&set, &acc_set, &tmp);
		if (!is_empty(&tmp)) {
			is_destroy(&set);
			is_destroy(&acc_set);
			is_destroy(&tmp);
			*pend = string + 1;
			return 1;
		}
	} while (*(++string) && !is_empty(&set));
	is_destroy(&set);
	is_destroy(&acc_set);
	is_destroy(&tmp);
	*pend = string;
	return 0;
}
