#ifndef _JLTIO_H_
#define _JLTIO_H_

#include <unistd.h>
#include <errno.h>
#define MAXLINE 4096

/* Läser en rad från en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare där resultatet skall lagras (vanligen en char array)
 * maxlen - maximalt antal tecken att lagra
 * Returvärde: antal inlästa bytes eller -1 för fel
 */
ssize_t readline(int fd, void *vptr, size_t maxlen);

/* Läser n-antal tecken från en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare där resultatet skall lagras (vanligen en char array)
 * n - antal tecken att lagra
 * Returvärde: antal inlästa bytes eller -1 för fel
 */
ssize_t	readn(int fd, void *vptr, size_t n);

/* Skriver n-antal tecken till en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare som håller det som skall skrivas (vanligen en char array)
 * n - antal tecken att skriva
 * Returvärde: antal skriva bytes eller -1 för fel
 */
ssize_t writen(int fd, const void *vptr, size_t n);

/* Hjälpfunktion för readline */
static ssize_t my_read(int fd, char *ptr);

#endif
