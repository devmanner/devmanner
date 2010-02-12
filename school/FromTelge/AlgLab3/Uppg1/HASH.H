#ifndef HASH_H
#define HASH_H

typedef int KeyType;

typedef struct {
	KeyType key;
} Entry;

typedef Entry* HashTable;

void CreateTable(HashTable *H);
void ClearTable(HashTable H);
void Insert(HashTable H, Entry newitem);
int RetriveTable(HashTable H, KeyType target);
void Traverse(HashTable H, void(*Visit)(Entry));
void FreeTable(HashTable *H);

#endif
