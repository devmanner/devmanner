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

#define await(x)

struct Node* search(struct List *l, int x) {
  struct Node *p;
  /* Zero elements in list */
  if (l->first == l->last && l->last->next)
    return NULL;
  /* One element in list */
  else if (l->first == l->last && !l->last->next)
    return (l->last->x == x) ? l->last : NULL;    
  for (p = l->first; p; p = p->next)
    if (p->x == x)
      return p;
  return NULL;
}

struct Node* delete(struct List *l) {
  /* Zero elements in list */
  if (l->first == l->last && l->last->next)
    return NULL;
  /* One element in list */
  else if (l->first == l->last && !l->last->next) {
    l->first->next = (struct Node*)0x666;
    return l->first;
  }
  struct Node *tmp = l->first;
  l->first = l->first->next;
  return tmp;
}

void insert(struct List *l, int x) {
  /* Empty list. */
  if (l->first == l->last && l->last->next) {
    l->last->x = x;
    l->last->next = NULL;
  }
  else {
    struct Node *new = malloc(sizeof(struct Node));
    new->x = x;
    new->next = NULL;
    l->last->next = new;
    l->last = new;
  }
}

void init(struct List *l) {
  l->first = l->last = malloc(sizeof(struct Node));
  l->last->next = (struct Node*)0x666;
}

void clear(struct List *l) {
  /* Zero elements in list */
  if (l->first == l->last && l->last->next)
    return;
  /* One element in list */
  else if (l->first == l->last && !l->last->next) {
    l->last->next = (struct Node*)0x666;
    return;
  }
  struct Node *p, *next;
  for (p = next = l->first; p->next; p = next) {
    next = next->next;
    free(p);
  }
  l->first = l->last = p;
  p->next = (struct Node*)0x666;
}

void print(struct List* l) {
  struct Node *p;
  /* Zero elements in list */
  if (!(l->first == l->last && l->last->next)) {
    for (p = l->first; p; p = p->next)
      printf("%d ", p->x);
  }
  else if (l->first == l->last && !l->last->next) {
    printf("%d", l->last->x);
  }
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


  insert(&l, 1);
  insert(&l, 2);
  insert(&l, 3);
  print(&l);
  clear(&l);
  print(&l);

  clear(&l);

  return 0;
}
