#include <stdio.h>

// Base
struct Base {
  struct Base *this;
};

void* Construct(size_t size, void (Init)(struct Base*)) {
  struct Base *p = (struct Base*) malloc(size);
  p->this = p;
  Init(p);
  return p;
}

// "Derived"
struct Object {
  struct Base base;
  int m_int;
  void (*m_func)(struct Object*);
};

void func(struct Object *p) {
  printf("func()\n");
}

void init(struct Base *p) {
  struct Object *ptr = (struct Object*) p;
  ptr->m_int = 10;
  ptr->m_func = func;
  ptr->m_func(ptr);
}


int main() {
  struct Object *ptr = (struct Object*) Construct(sizeof(struct Object), init);
  ptr->m_func(0);
  return 0;
}


