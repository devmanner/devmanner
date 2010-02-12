#ifndef LLIST_H
#define LLIST_H

#define EQ(a,b)((a)==(b))
#define LT(a,b)((a)<(b))

#ifndef MAXSIZE
#define MAXSIZE 10000
#endif

//-------------------------------------------------typedefar
typedef char KeyType[30];

typedef struct{
	char fname[20];
	char lname[30];
   char group;
   int left;
	KeyType key;
}ListEntry;

typedef struct node {
	ListEntry cont;
	struct node *next;
} ListNode;

typedef ListNode* List;

//-------------------------------------------------funktioner
void InsSort(List *list);
void CreateList(List *list);
void ClearList(List *list);
Bool ListEmpty(const List *list);
Bool ListFull(const List *list);
int ListSize(const List *list);
//void DeleteList(List *list);
void TraverseList(List *list, void(*Visit)(ListEntry));
ListEntry RetriveList(List *list, int num);
//ListEntry Serve(List *list, int which);
void InsertList(List *list, ListEntry x);

#endif