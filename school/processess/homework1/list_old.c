#include <stdio.h>
#include <stdlib.h>

struct Node;

struct List {
  struct Node *first;
  struct Node *last;
};

struct Node {
  int x;
  struct Node *next;
};

struct Node* search(struct List *l, int x) {
  struct Node *p;
  for (p = l->last; p; p = p->next)
    if (p->x == x)
      return p;
  return NULL;
}

struct Node* delete(struct List *l) {
  struct Node *tmp;
  tmp = l->first;
  /* One ore zero items in list. */
  if (l->first == l->last)
    l->first = l->last = NULL;
  else {
    for (l->first = l->last; l->first->next->next; l->first = l->first->next)
      ;
    l->first->next = NULL;
  }
  return tmp;
}

void insert(struct List *l, int x) {
  struct Node *new = malloc(sizeof(struct Node));
  new->x = x;
  new->next = l->last;
  l->last = new;
  if (!l->first)
    l->first = new;
}

void init(struct List *l) {
  l->first = l->last = NULL;
}

void clear(struct List *l) {
  struct Node *p, *next;
  for (p = next = l->last; p; p = next) {
    next = next->next;
    free(p);
  }
  l->first = l->last = NULL;
}

void print(struct List* l) {
  struct Node *p;
  for (p = l->last; p; p = p->next)
    printf("%d ", p->x);
  puts("");
}

int main() {
  struct List l;

  init(&l);

  insert(&l, 1);
  print(&l);
  insert(&l, 2);
  print(&l);
  insert(&l, 3);
  print(&l);

  struct Node *tmp = delete(&l);
  print(&l);
  free(tmp);
  tmp = delete(&l);
  print(&l);
  free(tmp);

  tmp = delete(&l);
  if (!tmp)
    printf("tmp == NULL\n");
  print(&l);
  free(tmp);

  clear(&l);
  return 0;
}
