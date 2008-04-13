#ifndef CONTAINER_H_INCLUDED
#define CONTAINER_H_INCLUDED

#include <stddef.h>

struct container;

typedef struct {
	void(*size)(struct container*);
} container_vtable;


typedef struct {
	container_vtable *m_vtable;
	size_t m_size;
} container;

void container_init(container *this, container_vtable *vtable) {
	this->m_size = 0;
	this->m_base->m_vtable = vtable;
}

#endif
