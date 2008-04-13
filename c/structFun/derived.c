#include <stdlib.h>
#include <stdio.h>

struct Base {
  int m_int;
  float m_float;
};

struct Der1 {
  struct Base m_base;
  int m_int;
};

struct Der2 {
  struct Base m_base;
  float m_float;
};

int main() {
  struct Der2 *p2;
  struct Der1 *p = (struct Der1*) malloc(sizeof(struct Der1));
  p->m_base.m_int = p->m_int = 2;
  p->m_base.m_float = 2.5;

  p2 = (struct Der2*) p;
  printf("p2->m_base.m_int: %d\np2->m_base.m_float: %.2f\n", p2->m_base.m_int, p2->m_base.m_float);
  free(p2);
  return 0;
}
