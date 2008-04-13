#include <stdio.h>

#define DEBUG_MODE
#include "debuginfo.h"

int main () {
  int i=1;
  unsigned int ui =2;
  long int li = 3;
  unsigned long int uli = 4;
  short s = 5;
  unsigned short us = 6;
  char c= '7';
  unsigned char uc='8';
  char* cp= "9";
  unsigned char* ucp= "10";
  double d= 11.;
  float f= 12.;

  const int ci=1;
  const unsigned int cui =2;
  const long int cli = 3;
  const unsigned long int culi = 4;
  const short cs = 5;
  const unsigned short cus = 6;
  const char cc= '7';
  const unsigned char cuc='8';
  const char* ccp= "9";
  const unsigned char* cucp= "10";
  const double cd= 11.;
  const float cf= 12.;
  
  DBG(i);
  DBG(ui);
  DBG(li);
  DBG(uli);
  DBG(s);
  DBG(us);
  DBG(c);
  DBG(uc);
  DBG(cp);
  DBG(ucp);
  DBG(d);
  DBG(f);

  DBG(ci);
  DBG(cui);
  DBG(cli);
  DBG(culi);
  DBG(cs);
  DBG(cus);
  DBG(cc);
  DBG(cuc);
  DBG(ccp);
  DBG(cucp);
  DBG(cd);
  DBG(cf);

  return 0;
}
