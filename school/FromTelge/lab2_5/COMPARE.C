//#define MAXSIZE 10
//#define RANDMAX 1000

#include "common.h"
#include "list.h"

// Global vatiabel f”r antalet nyckelj„mf”relser.
unsigned int comps;

void InitRand(void);
void PrintKey(ListEntry x);
void FillList(List *list, int max, int size);
float TestSearch(int(*SearchType)(List*, KeyType), List *list, int keymax);

main() {
	List myList;
	int listsize = 0;
	clock_t start;

	comps = 0;
	clrscr();
	InitRand();

	do {
		do {
			printf("\nAnge liststorlek. (Avsluta med 0): ");
			scanf("%d", &listsize);
		} while (listsize > MAXSIZE);

		if (listsize == 0)
			break;

		CreateList(&myList, listsize);
		FillList(&myList, (listsize * 2), listsize);

		comps = 0;
		start = clock();
		printf("Antal j„mf”relser med bin„r s”kning: %f\n", TestSearch(BinSearch, &myList, (listsize * 2)));
		printf("S”ktid 100 s”kningar: %f\n", (clock() - start) / CLK_TCK);

		comps = 0;
		start = clock();
		printf("Antal j„mf”relser med linj„r s”kning: %f\n", TestSearch(SeqSearch, &myList, (listsize * 2)));
		printf("S”ktid 100 s”kningar: %f\n", (clock() - start) / CLK_TCK);

		DeleteList(&myList);

	} while (listsize != 0);

	return 0;
}

float TestSearch(int(*SearchType)(List*, KeyType), List *list, int keymax) {
	int register cnt;
	KeyType key;

	for (cnt = 0; cnt < 100; cnt ++) {
		key = rand() % keymax + 1;
		(*SearchType)(list, key);
	}

	return (comps / 100.0);
}

void FillList(List *list, int max, int size) {
	ListEntry rnd;

	while (ListSize(list) < size) {
		rnd.key = rand() % max + 1;
		InsertOrder(list, rnd);
	}
}

void InitRand(void) {
	srand(time(NULL));
}

void PrintKey(ListEntry x) {
	printf(" %d", x.key);
}
