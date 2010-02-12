//#define MAXSIZE 10

#include "common.h"
#include "list.h"

void FillList(List *list);
void InitRand(void);
void PrintKey(ListEntry x);

main() {
	List myList;

   InitRand();
   FillList(&myList);
   TraverseList(&myList, PrintKey);

	getch();
   return 0;
}

void FillList(List *list) {
   int register cnt;
   ListEntry rnd;

   for (cnt = 0; ListSize(list) < MAXSIZE; cnt ++) {
   	rnd.key = rand() % 1000 + 1;
//printf("%d\n", rnd.key);
		InsertOrder(list, rnd);
   }
}

void InitRand(void) {
	srand(time(NULL));
}

void PrintKey(ListEntry x) {
	printf(" %d", x.key);
}
