#ifndef FILE_FUN_H_INCLUDED
#define FILE_FUN_H_INCLUDED

#include <strings.h>
#include <libgen.h>
#include <stdio.h>

/*
 * Read a from fp until \n is foud.
 * Return value: -1 => Error, 0 => Reading is ok.
 * Pre: fp is a valid FILE*, dest is a pointer to a memory area of size max.
 * Post: dest is filled with maximum max bytes of data.
 */
int readline(FILE* fp, char* dest, size_t max);

/* Search file (fp) for the regular expression sz_regexp. File is read "linewise" so sz_regexp must be matched on one row.
 * Return values:
 * 0 => Fond a match, fp is set to where match began/ended depending on setpos.
 * -1 => Not found, fp is not changed.
 * -2 => Invalid regular expression, fp is not changed.
 * Note: The fwd_to works even with fp == stdin.
 */

#define SET_FP_AFTER 0
#define SET_FP_BEFORE 1

int fwd_to(FILE *fp, char *sz_regexp, int setpos);

#endif
