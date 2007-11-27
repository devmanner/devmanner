/*******************************************************************
 * Filename: exception.h                                           *
 *                                                                 *
 * Version: 0.01b                                                  *
 *                                                                 *
 * Author: Tomas Mannerstedt manner@drunkencoder.com               *
 *                                                                 *
 * Description: A collection of macros used for C++/Java style     *
 * exceptions.                                                     *
 *                                                                 *
 * Usage:                                                          *
 * #define EXCEPTION_F1 1                                          *
 * void f1(void) {                                                 *
 *   printf("f1()\n");                                             *
 *   THROW(EXCEPTION_F1, "Exception in f1!!!");                    *
 * }                                                               *
 * ...later in the program:                                        *
 * EXCEPTION ex;                                                   *
 * TRY {                                                           *
 *   f1();                                                         *
 * }                                                               *
 * CATCH(ex) {                                                     *
 *   switch(GET_EXCEPTION_TYPE(ex)) {                              *
 *   case EXCEPTION_F1:                                            *
 *     printf("ex1 %s\n", GET_MESSAGE(ex));                        *
 *     break;                                                      *
 *   default:                                                      *
 *     printf("Some other exception: %s\n", GET_MESSAGE(ex));      *
 *     break;                                                      *
 *   }                                                             *
 * }                                                               *
 * CLEAR_EXCEPTION(ex);                                            *
 *                                                                 *
 * Note: Don't THROW or TRY unless you have cleared previous       *
 * exceptions.                                                     *
 *                                                                 *
 * Licanse: As free as possible...                                 *
 ******************************************************************/

#ifndef EXCEPTION_H_INCLUDED
#define EXCEPTION_H_INCLUDED

#include <setjmp.h>
#include <string.h>
#include <stdlib.h>

/* Typedefs. */
typedef struct {
  int m_code;
  char *m_msg;
} EXCEPTION;

/* Some globals... */
jmp_buf __eb;
EXCEPTION __exception;

/* The macros. */
#define TRY \
__exception.m_msg = NULL; \
__exception.m_code = 0; \
if (setjmp(__eb) == 0)

#define THROW(e, m) \
do { \
__exception.m_msg = malloc(sizeof(char) * strlen(m)); \
strcpy(__exception.m_msg, m); \
__exception.m_code = e; \
longjmp(__eb, e); \
} while (0); 

#define CATCH(e) else if (((e).m_code = __exception.m_code) | (int)((e).m_msg = __exception.m_msg) ) // My god ;-)

#define GET_EXCEPTION_TYPE(e) ((e).m_code)

#define GET_MESSAGE(e) ((e).m_msg)

#define CLEAR_EXCEPTION(e) free((e).m_msg);

#endif /* EXCEPTION_H_INCLUDED */

