#include <stdio.h>
#include <stdlib.h>
#include <conio.h>


void Error(char *message) {
	fprintf(stderr, "\nError: %s\n", message);
	getch();
	exit(1);
}

void Warning(char *message) {
	fprintf(stderr, "\nWarning: %s\n", message);
}

unsigned int getInt(void) {
	char buffer[80] = {0};
	int check_num = 0;
	unsigned int return_num = 0;

	while (check_num != 1) {
		gets(buffer);
		check_num = sscanf(buffer, "%d", &return_num);

		if (check_num != 1) {
			printf("\nFelaktig inmatning. F”rs”k igen.\n");
		}
	}

	return return_num;
}
