#ifndef UNIQUE_CLASS_INCLUDED
#define UNIQUE_CLASS_INCLUDED

class Foo {
  static int m_nProd; /* Antal producerade instanser.*/
  int m_id; /* Klassens id. */

public:
  Foo() : m_id(++m_nProd) {}
  inline int getId() { return m_id; }  
};

#endif
