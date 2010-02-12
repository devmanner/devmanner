#include "common.h"
#include "list.h"



int SeqSearch(List *list, KeyType key) {
	int location;

	if (ListEmpty(list))
		return -1;

	for (location = 0; location < ListSize(list); location ++)
		if (list->entry[location].key == key)
			return location;

	return -1;
}

void CreateList(List *list){
		list->entry = malloc(sizeof(ListEntry) * MAXSIZE);
		list->size = 0;
}

void ClearList(List *list){       //ok?
	list->size = 0;
}

Bool ListEmpty(const List *list){
		return (list->size == 0);
}

Bool ListFull(const List *list){
	return(list->size >= MAXSIZE);
}

int ListSize(const List *list){
		return list->size;
}

void DeleteList(List *list){
		free(list->entry);
      list->size = 0;
}

/*TraverseList
pre:	the list has been created
post:	the action specified by function Visit has been preformed on every entry
		of list, beginning at the first entry and doing each in turn*/

void TraverseList(List *list, void(*Visit)(ListEntry)){
	int i;
   for(i=0; i < list->size; i ++)
   	(*Visit)(list->entry[i]);
}

ListEntry RetriveList(List *list, int num) {
	return list->entry[num];
}

void InsertList(List *list, ListEntry x, int before) {
	int cnt;
	if (!ListFull(list)) {
   	for (cnt = ListSize(list); cnt > before; cnt --) {
      	list->entry[cnt] = list->entry[cnt - 1];
      }
      list->entry[before] = x;
      list->size ++;
   }
   else {
   	Warning("Listan är full.");
  	}
}

/* InsertOrder: insert an item into list maintaining correct order.
Pre:	listan list (array) har skapats, är ordnad men inte full
Post:	entry x har lagts in i list på rätt pos */

void InsertOrder(List *list, ListEntry x){
	int current;
   ListEntry currententry;

   for(current = 0; current < ListSize(list); current++){
   	currententry = RetriveList(list, current);
//    if(LE(x.key, currententry.key))
      if(x.key < currententry.key)
      	break;
   }
   InsertList(list, x, current);
}

ListEntry Serve(List *list, int which) {
	int cnt;
   ListEntry tmp;

   if (ListEmpty(list)) {
   	Error("Listan är tom toker!");
   }

	which = which % ListSize(list);
   tmp = list->entry[which];
   for (cnt = which; cnt < (ListSize(list) - 1); cnt ++) {
		list->entry[cnt] = list->entry[cnt + 1];
   }
	list->size --;
   return tmp;
}

