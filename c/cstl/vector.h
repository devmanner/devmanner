#ifndef VECTOR_H_INCLUDED
#define VECTOR_H_INCLUDED

#include <container.h>

#include <stddef.h>
#include <stdlib.h>

/* Make sure this is a power of two. */
#define VECTOR_INIT_SIZE 1 << 6

typedef struct {
	container m_base;
	size_t m_head, m_tail, m_alloced, m_elemSize;
} vector;

#define vector_define(Type) typedef struct { \
vector m_base; \
typeof(Type) *m_data; \
} vector_##Type

size_t vector_size(vector *this) {
	return abs(this->m_head - this->m_tail);
}

/* Constructor */
#define vector_init(X) do { \
X.m_base.m_head = X.m_base.m_tail = 0; \
X.m_data = malloc(sizeof(typeof(X.m_data[0])) * (X.m_base.m_alloced = VECTOR_INIT_SIZE)); \
X.m_base.m_base.m_vtable->size = (void(*)(container*))vector_size; \
} while(0)

#endif

