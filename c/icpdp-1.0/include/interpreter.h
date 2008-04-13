#ifndef INTERPRETER_H_INCLUDED
#define INTERPRETER_H_INCLUDED

#include <stdio.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>

#include "bit_fun.h"
#include "file_fun.h"
#include "options.h"
#include "algorithm.h"
#include "types.h"
#include "limits.h"

/* Maximum length in bytes. */
#define MAXIMUM_MESSAGE_LENGTH 1024

/* SOme return types. */
struct range {
  int start;
  int stop;
};

struct interpret_reply {
  int error;
  size_t tunneled_bytes;
  size_t decoded_bytes;
};

/* interpret(..) return codes. */
#define INTERR_AC_NOT_FOUND_IN_CONF_FILE -1
#define CONFIGFILE_NOT_FOUND -2
#define UNMATCHED_SIZE -3
#define IO_ERROR -4
#define ILLEGAL_RANGE -5

void interpret(const char *sz_appName, BOOL b_isAnswer, struct message *mess, const int options, const char *sz_ofile, const char *sz_date);
#endif


