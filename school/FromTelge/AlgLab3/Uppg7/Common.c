#include "COMMON.H"

void InitRand(void) {
	srand(time(NULL));
}

void Warning(char *med){
	fprintf(stderr, "\tVarning: %s\n", med);
}

void Error(char *med){
	fprintf(stderr, "\tError: %s\n", med);
	exit(1);
}