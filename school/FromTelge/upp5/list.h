#ifndef LIST_H
#define LIST_H

#define EQ(a,b)((a)==(b))
#define LT(a,b)((a)<(b))

#ifndef MAXSIZE
#define MAXSIZE 10
#endif

//-------------------------------------------------typedefar
typedef int KeyType;

typedef struct{
		KeyType key;
}ListEntry;

typedef struct{
	int size;
   ListEntry *entry;
}List;

//-------------------------------------------------funktioner
int BinSearch(List *list, KeyType key);
int RecBinSearch(List *list, KeyType key, int first, int last); 
int SeqSearch(List *list, KeyType key);
void CreateList(List *list);
void ClearList(List *list);
Bool ListEmpty(const List *list);
Bool ListFull(const List *list);
int ListSize(const List *list);
void DeleteList(List *list);
void TraverseList(List *list, void(*Visit)(ListEntry));
void InsertOrder(List *list, ListEntry x);
ListEntry RetriveList(List *list, int num);
ListEntry Serve(List *list, int which);

#endif