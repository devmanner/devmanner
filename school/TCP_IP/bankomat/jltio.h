#ifndef _JLTIO_H_
#define _JLTIO_H_

#include <unistd.h>
#include <errno.h>
#define MAXLINE 4096

/* L�ser en rad fr�n en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare d�r resultatet skall lagras (vanligen en char array)
 * maxlen - maximalt antal tecken att lagra
 * Returv�rde: antal inl�sta bytes eller -1 f�r fel
 */
ssize_t readline(int fd, void *vptr, size_t maxlen);

/* L�ser n-antal tecken fr�n en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare d�r resultatet skall lagras (vanligen en char array)
 * n - antal tecken att lagra
 * Returv�rde: antal inl�sta bytes eller -1 f�r fel
 */
ssize_t	readn(int fd, void *vptr, size_t n);

/* Skriver n-antal tecken till en deskriptor
 * Inparametrar: 
 * fd - socketdeskriptor
 * vptr - voidpekare som h�ller det som skall skrivas (vanligen en char array)
 * n - antal tecken att skriva
 * Returv�rde: antal skriva bytes eller -1 f�r fel
 */
ssize_t writen(int fd, const void *vptr, size_t n);

/* Hj�lpfunktion f�r readline */
static ssize_t my_read(int fd, char *ptr);

#endif
