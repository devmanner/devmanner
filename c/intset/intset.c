#include "intset.h"

void is_init(int_set *s, const size_t max) {
  s->elements = (size_t) ceil(max/(8.0*sizeof(data_t)));
  s->data = malloc(s->elements*sizeof(data_t));
  assert(s->data);
  memset(s->data, 0, s->elements*sizeof(data_t));
}

void is_swap(int_set *s1, int_set *s2) {
	int_set tmp = *s1;
	*s1 = *s2;
	*s2 = tmp;
}

void is_resize(int_set *s, size_t max) {
  size_t old = s->elements;
  s->elements = (size_t) ceil(max/(8.0*sizeof(data_t)));
  s->data = realloc(s->data, s->elements);
  assert(s->data);
  memset(s->data+old, 0, (s->elements - old) * sizeof(data_t));
}

void is_destroy(int_set *s) {
  free(s->data);
  s->data = NULL;
  s->elements = 0;
}

void is_clear(int_set *s) {
  memset(s->data, 0, s->elements * sizeof(data_t));
}

data_t is_find(const int_set *s, unsigned int x) {
  if (x >= s->elements*8*sizeof(data_t))
    return 0;  
  return ( (s->data[x/(8*sizeof(data_t))] >> (x%(8*sizeof(data_t)))) ) & 0x1;
}

void is_insert(int_set *s, const unsigned int x) {
  if (x >= s->elements*8*sizeof(data_t))
    is_resize(s, x);
  s->data[x/(8*sizeof(data_t))] |= 0x1 << (x%(8*sizeof(data_t)));
}

void is_remove(int_set *s, const unsigned int x) {
  if (x >= s->elements*8*sizeof(data_t))
    return;
  s->data[x/(8*sizeof(data_t))] &= ~(0x1 << (x%(8*sizeof(data_t))));
}

/* Calculate res = s1 UNION s2 */
void is_union(int_set *s1, int_set *s2, int_set *res) {
  int i;
  size_t max_elem = MAX(s1->elements, s2->elements);
  if (res->elements < max_elem)
    is_resize(res, max_elem);
  is_clear(res);
  for (i = 0; i < max_elem; ++i)
    res->data[i] = s1->data[i] | s2->data[i];
}

/* Calculate res = s1 INTERSECTION s2 */
void is_intersect(int_set *s1, int_set *s2, int_set *res) {
  int i;
  size_t max_elem = MAX(s1->elements, s2->elements);
  if (res->elements < max_elem)
    is_resize(res, max_elem);
  is_clear(res);
  for (i = 0; i < max_elem; ++i)
    res->data[i] = s1->data[i] & s2->data[i];
}

int is_empty(const int_set *s) {
  int i;
  for (i = 0; i < s->elements; ++i)
    if (s->data[i])
      return 0;
  return 1;
}
 
void is_print(const int_set *s) {
  int i;
  printf("{");
  for (i = 0; i < s->elements*8*sizeof(data_t)-1; ++i)
    if (is_find(s, i))
      printf("%d ", i);
  printf("}\n");
} 

