#include "common.h"
#include "llist.h"

void PrintListEntry(ListEntry x);
void InitRand(void);
void FillList(List *list, int max, int ant);

main() {
	List myList;

   InitRand();
   CreateList(&myList);

   FillList(&myList, 200, 20);

   TraverseList(&myList, PrintListEntry);

   InsSort(&myList);

   printf("\n");
   TraverseList(&myList, PrintListEntry);

   ClearList(&myList);
	getch();
	return 0;
}

void FillList(List *list, int max, int ant) {
	ListEntry rnd;
   int startsize = ListSize(list);

	while (ListSize(list) < (startsize + ant)) {
		rnd.key = rand() % max + 1;
		InsertList(list, rnd);
	}
}

void InitRand(void) {
	srand(time(NULL));
}

void PrintListEntry(ListEntry x) {
	printf("%d ", x.key);
}