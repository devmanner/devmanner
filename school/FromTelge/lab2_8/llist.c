#include "common.h"
#include "llist.h"

void InsSort(List *list) {
	ListNode *fu, *ls, *curr, *trailing;

   if (!ListEmpty(list)) {
   	ls = *list;
      while (ls->next) {
      	fu = ls->next;
         if (strcmp(fu->cont.key, (*list)->cont.key) < 0) {
         	ls->next = fu->next;
            fu->next = *list;
            *list = fu;
         }
         else {
         	trailing = *list;
            for (curr = trailing->next; strcmp(fu->cont.key, curr->cont.key) > 0; curr = curr->next)
            	trailing = curr;

            if (fu == curr)
            	ls = fu;
            else {
            	ls->next = fu->next;
               fu->next = curr;
               trailing->next = fu;
            }
         }
      }
   }
}

void CreateList(List *list){
	*list = NULL;
}

void ClearList(List *list){
	ListNode *p, *pre;

	for (p = *list; p; ) {
		pre = p;
		p = p->next;
		free(pre);
	}
   *list = NULL;
}

Bool ListEmpty(const List *list){
	return (*list == NULL);
}

Bool ListFull(const List *list){
   ListNode *tmp;
   tmp = malloc(sizeof(ListNode));
   if (!tmp) {
   	free(tmp);
      return TRUE;
   }
   else {
   	free(tmp);
      return FALSE;
   }
}

int ListSize(const List *list){
	int size;
   ListNode *p;

   p = *list;
   for (size = 0; p; size ++)
   	p = p->next;

	return size;
}

/*void DeleteList(List *list){
	ClearList(list);
}*/

void TraverseList(List *list, void(*Visit)(ListEntry)) {
	ListNode *p;
   for (p = *list; p; p = p->next)
		(*Visit)(p->cont);
}

// Nollräkning på num.
ListEntry RetriveList(List *list, int num) {
	int register cnt = 1;
   ListNode *p;

	for (p = *list; cnt <= num; cnt ++)
   	p = p->next;

	return p->cont;
}

void InsertList(List *list, ListEntry x) {
	ListNode *p;

	if (!ListFull(list)) {
   	p =  malloc(sizeof(ListNode));
      p->cont = x;
      p->next = *list;
      *list = p;
	}
   else {
		Warning("Listan är full.");
	}
}

/*ListEntry Serve(List *list, int which) {
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
}*/

