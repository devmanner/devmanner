#ifndef TYPES_H_INCLUDED
#define TYPES_H_INCLUDED

/*
 * User-defined types
 */

typedef char BYTE;
typedef short int TWOBYTE;
typedef int FOURBYTE;

typedef unsigned char UBYTE;
typedef unsigned short int UTWOBYTE;
typedef unsigned int UFOURBYTE;

typedef int BOOL;
#define FALSE 0
#define TRUE !FALSE

struct message {
  UTWOBYTE AC;
  UTWOBYTE LI;
  UBYTE *PA;
};




#endif
