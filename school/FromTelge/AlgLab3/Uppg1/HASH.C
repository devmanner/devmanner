#include "hash.h"
#include "common.h"

int hashsize, comps;

int Hash(KeyType key) {
	return key % hashsize;
}

void CreateTable(HashTable *H) {
	if (!(*H))
		*H = malloc(hashsize * sizeof(Entry));
   else
   	realloc(*H, hashsize * sizeof(Entry));
   if (!(*H)) {
   	free(*H);
		*H = malloc(hashsize * sizeof(Entry));
   }

   if (!(*H))
   	Error("Kan inte allokera minne!!!");

//   printf("Addr till h i create: %d\n", *H);
   ClearTable(*H);
}

void FreeTable(HashTable *H) {
	free(*H);
//   printf("Addr till h i free: %d\n", *H);
   *H = NULL;
}

// Sätter alla element i hashen till 0 (enl. def.)
void ClearTable(HashTable H) {
	int cnt;
   for (cnt = 0; cnt < hashsize; cnt ++)
   	H[cnt].key = 0;
}

void Insert(HashTable H, Entry newitem) {
	int i = 0;
	while (H[Hash(i + newitem.key)].key ) {
   	i ++;
      if (i > hashsize) {
      	Warning("Hash full!!!");
         return;
      }
   }
   H[i + Hash(newitem.key)] = newitem;
}

int RetriveTable(HashTable H, KeyType target) {
	int cnt = 0;
	while (comps ++, target != H[Hash(target + cnt)].key) {
   	cnt ++;
      if (cnt > hashsize)
      	return -1;
   }
	return Hash(target + cnt);
}

void Traverse(HashTable H, void(*Visit)(Entry)) {
	int cnt;
   for (cnt = 0; cnt < hashsize; cnt ++) {
     	(*Visit)(H[Hash(cnt)]);
   }
}

