#include "common.h"
#include "hash.h"

extern int hashsize, comps;

void fillRand(HashTable H, int ant, int min, int max);
void Print(Entry x);

main() {
	HashTable hash = NULL;
   KeyType tmp;
   int cnt;
   InitRand();

   clrscr();
	do {
		printf("\nMata in hashstorlek: ");
   	scanf(" %d", &hashsize);

	   CreateTable(&hash);
   	fillRand(hash, hashsize - 1, 15, 25);

	   printf("\n\nHashen: ");
   	Traverse(hash, Print);
	   printf("\n");

		printf("\nAnge ett element du vill söka efter: ");
	   scanf(" %d", &tmp);

   	if (RetriveTable(hash, tmp) == -1)
   		printf("\nNyckeln finns inte!");
	   else
   		printf("\nNyckeln finns på index: %d\n", RetriveTable(hash, tmp));

      printf("\nTryck q för att avsluta.");
	   FreeTable(&hash);
   } while (getch() != 'q');

//   return 0;

   printf("\n\nSöker i stor tabell....");
   hashsize = 10007;		// Primtal direkt över 10000
   CreateTable(&hash);
   fillRand(hash, 10000, 15000, 25000);

   comps = 0;
	for (cnt = 0; cnt < 100; cnt ++) {
   	tmp = rand() % 10001 + 15000;
      RetriveTable(hash, tmp);
   }

   printf("\nAntal nyckeljämförelser 100 sökningar: %d", comps);

   FreeTable(&hash);
   getch();
   return 0;
}

void fillRand(HashTable H, int ant, int min, int max) {
	int cnt;
   Entry tmp;

   for (cnt = 0; cnt < ant; cnt ++) {
	   tmp.key = rand() % (max - min + 1) + min;
   	Insert(H, tmp);
   }
}

void Print(Entry x) {
	if (x.key)
		printf("%d ", x.key);
   else
   	printf("  ");
}