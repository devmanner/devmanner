#ifndef STACK_H_INCLUDED
#define STACK_H_INCLUDED

#include <stdlib.h>


#define stack(TYPE, NAME) \
struct { \
  size_t m_size; \
  size_t m_node_size; \
  struct { void *m_next; typeof(TYPE) m_data; } *m_head; \
} NAME; \
NAME.m_size = 0; \
NAME.m_node_size = sizeof(struct { void *m_next; typeof(TYPE) m_data; }); \
NAME. m_head = malloc(NAME.m_node_size);

#define stack_size(d) d.m_size

#define stack_push(d, x) \
do { \
  ++d.m_size; \
  typeof(d.m_head) tmp = malloc(d.m_node_size); \
  tmp->m_data = x; \
  tmp->m_next = d.m_head; \
  d.m_head = tmp; \
} while (0);

#define stack_pop(s) \
s.m_head->m_data; \
do { \
  --s.m_size; \
  typeof(s.m_head) tmp = s.m_head; \
  s.m_head = s.m_head->m_next; \
  free(tmp); \
} while(0);


#define stack_destroy(d) \
do { \
  int i; \
  typeof(d.m_head) p; \
  typeof(d.m_head) *list; \
  list = malloc(sizeof(typeof(d.m_head)) * d.m_size); \
  for (i = 0, p = d.m_head; p != NULL; p = p->m_next, ++i) \
    list[i] = p; \
  for (i = 0; i < d.m_size; ++i) \
    free(list[i]); \
} while(0);

#endif /* STACK_H_INCLUDED */
