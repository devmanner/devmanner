/*******************************************************************
 * Filename: debuginfo.h                                           *
 *                                                                 *
 * Version: 0.11                                                   *
 *                                                                 *
 * Author: Tomas Mannerstedt manner@drunkencoder.com               *
 *                                                                 *
 * Description: A small and fancy marco to display debug           *
 * information run-time. It is enabled by:                         *
 *                                                                 *
 * #define DEBUG_MODE                                              *
 * #include "debuginfo.h"                                          *
 *                                                                 *
 * And the macro is later on called with:                          *
 *                                                                 *
 * int x = 10;                                                     *
 * DBG(x);                                                         *
 *                                                                 *
 * Output is then:                                                 *
 *                                                                 *
 * yourfile.c:[row] x = 5                                          *
 *                                                                 *
 * Supported types: The following types are supported:             *
 * int                                                             *
 * unsigned int                                                    *
 * const int                                                       *
 * const unsigned int                                              *
 * long int                                                        *
 * unsigned long int                                               *
 * const long int                                                  *
 * const unsigned long int                                         *
 * short                                                           *
 * unsigned short                                                  *
 * const short                                                     *
 * const unsigned short                                            *
 * char                                                            *
 * unsigned char                                                   *
 * const char                                                      *
 * const unsigned char                                             *
 * char*                                                           *
 * unsigned char*                                                  *
 * const char*                                                     *
 * const unsigned char*                                            *
 * double                                                          *
 * const double                                                    *
 * float                                                           *
 * const float                                                     *
 * Types specified by typedef is also supported (for example:      *
 * size_t).                                                        *
 *                                                                 *
 * Note: This macro is currently only working with GCC. It's only  *
 * tested with gcc 3.2.2 but will probably work with other         *
 * versions of gcc.                                                *
 *                                                                 *
 * License: As free as possible...                                 *
 *                                                                 *
 * History:                                                        *
 * 2004-03-05 First release. Version 0.01b                         *
 * 2004-03-20 Removed warnings, added more types. Version 0.1      *
 * 2004-03-26 Added the __func__ to print.                         *
 ******************************************************************/

#ifndef DEBUGINFO_H_INCLUDED
#define DEBUGINFO_H_INCLUDED

#include <stdio.h>

#ifdef DEBUG_MODE

#ifdef __GNUC__

/* If you are missing any type, add it in the lines below. */

#define DBG(x) \
do { \
  char* format; \
  if (__builtin_types_compatible_p(typeof(x), int) || \
      __builtin_types_compatible_p(typeof(x), unsigned int) || \
      __builtin_types_compatible_p(typeof(x), short int) || \
      __builtin_types_compatible_p(typeof(x), unsigned short int) ) \
    format = "%d\n"; \
  else if (__builtin_types_compatible_p(typeof(x), long int) || \
	   __builtin_types_compatible_p(typeof(x), unsigned long int) ) \
    format = "%ld\n"; \
  else if (__builtin_types_compatible_p(typeof(x), double) || \
	   __builtin_types_compatible_p(typeof(x), double) || \
	   __builtin_types_compatible_p(typeof(x), float) || \
	   __builtin_types_compatible_p(typeof(x), float) ) \
    format = "%f\n"; \
  else if (__builtin_types_compatible_p(typeof(x), char) || \
	   __builtin_types_compatible_p(typeof(x), unsigned char) ) \
    format = "%c\n"; \
  else if (__builtin_types_compatible_p(typeof(x), char*) || \
	   __builtin_types_compatible_p(typeof(x), const char*) || \
	   __builtin_types_compatible_p(typeof(x), unsigned char*) || \
	   __builtin_types_compatible_p(typeof(x), const unsigned char*) ) \
    format = "%s\n"; \
  else {\
    printf("Unsupported type in file: %s:%d function: %s variable: %s = 0x%x\n", __FILE__, __LINE__, __func__, #x, (unsigned int) x); \
    break; \
  } \
  printf("%s:%d (%s) %s = ", __FILE__, __LINE__, __func__, #x); \
  printf(format, x); \
} while (0);

#else /* typeof() probably not supported. */
/* This better be a warning instead of an error. */
#error "The debuginfo.h may _only_ be used with GCC since it uses typeof() and __builtin_types_compatible_p() available in GCC."
#endif /* __GNUC__ */

#else /* No debugmode defined. */
#define DBG(x) /* Do nothing... */
#endif /* DEBUG_MODE */

#endif /* DEBUGINFO_H_INCLUDED */
