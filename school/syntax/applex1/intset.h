#ifndef _INTSET_H_
#define _INTSET_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <assert.h>

#define MAX(x, y) ( (x < y) ? y : x)

typedef unsigned int data_t;

typedef struct _int_set {
  data_t *data;
  size_t elements;
} int_set;

void is_init(int_set *s, const size_t max);

void is_swap(int_set *s1, int_set *s2);
void is_resize(int_set *s, size_t max);
void is_destroy(int_set *s);
void is_clear(int_set *s);
data_t is_find(const int_set *s, unsigned int x);
void is_insert(int_set *s, const unsigned int x);
void is_remove(int_set *s, const unsigned int x);
/* Calculate res = s1 UNION s2 */
void is_union(int_set *s1, int_set *s2, int_set *res);
/* Calculate res = s1 INTERSECTION s2 */
void is_intersect(int_set *s1, int_set *s2, int_set *res);
int is_empty(const int_set *s);
void is_print(const int_set *s);

#endif

