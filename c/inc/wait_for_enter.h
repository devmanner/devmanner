#ifndef WAIT_FOR_ENTER
#define WAIT_FOR_ENTER

#ifdef UNIX
#define pause()
#else
#include <stdlib.h>
#define pause() system("PAUSE")
#endif

#endif
