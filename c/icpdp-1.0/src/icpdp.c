#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <assert.h>

#include "../include/algorithm.h"
#include "../include/bit_fun.h"
#include "../include/interpreter.h"
#include "../include/types.h"
#include "../include/options.h"
#include "../include/file_fun.h"
#include "../include/limits.h"


/* Return codes from the read_message function. */
#define MESSAGE_TOO_SHORT (-1)
#define MESSAGE_TOO_LONG (-2)
#define MESSAGE_IS_ILLEGAL (-3)

/*
#define DEBUG_MODE
#include "../include/debuginfo.h"
*/

/*
 * Descriotion: Step forward in fp until c is read.
 * Pre: fp is a valid file pointer.
 * Post: fp points at the position after the first occurance of c.
 * Return values:
 * 0      Everything is ok.
 * -1     fp is not a valid file pointer.
 * -2     EOF was reached before c.
 */
/*
static int fwd_to_char(FILE* fp, const char c) {
  char tmp;
  if (!fp)
    return -1;
  do {
    if (fscanf(fp, "%c", &tmp) == EOF)
      return -2;
  } while (c != tmp);
  return 0;
}
*/


/* 
 * Convert message from sz_mess (a plain hex string) to a data struct. sz_mess includes AC & LI field.
 */
static void convert_message(const char* sz_mess, struct message* mess) {
  /* Extract the first two bytes which is the AC-field. */
  mess->AC = (hex_extract(&(sz_mess[0])) << 8) | hex_extract(&(sz_mess[2]));

  /* Extract bytes 3 and 4 which is the LI-field. */
  mess->LI = (hex_extract(&(sz_mess[4])) << 8) | hex_extract(&(sz_mess[6]));

  /* Do we have something except the AC & LI field to extract? */
  if (mess->LI-4 > 0) {
    int i;
    /* Allocate memory for the PA block... */
    assert(mess->PA = malloc(sizeof(UBYTE) * (mess->LI-4)));
    /* ...and copy data from sz_buff2. */
    for (i = 0; i < mess->LI-4; ++i) {
      mess->PA[i] = hex_extract(&(sz_mess[i*2 + 8]));
    }
  } 
  else {
    mess->PA = NULL;
  } 
}



/*
 * sz_mess shall not have allocated memory.
 * Return values:
 * 0 => Ok
 * MESSAGE_TOO_SHORT => Cannot read LI-4 bytes for the PA field. The message is shorter than what the LI field says.
 * MESSAGE_TOO_LONG => The message is longer than the LI field says.
 * MESSAGE_IS_ILLEGAL => The resulting string contains illegal characters, characters not defined in legal.
 * Note: The method:
 * if (readline(fp, sz_buff, BIG_BUFF_SIZE)) {
 *    return -1;
 * }
 * sscanf(sz_buff, "%s", sz_buff);
 * is used to avoid buffer overflow.
 */
static int read_message(FILE *fp, char **sz_mess) {
  char sz_buff[BIG_BUFF_SIZE];
  /* Legal characters in a hex-string. */
  static char *legal = "abcdefABCDEF0123456789";
  UTWOBYTE LI;

  sz_buff[0] = '\0';
  fscanf(fp, "%s", sz_buff);

  /* Extract bytes 3 and 4 which is the LI-field. */
  LI = (hex_extract(&(sz_buff[4])) << 8) | hex_extract(&(sz_buff[6]));

  /* Check the length of the read part of the message. */
  if (strlen(sz_buff) / 2 > LI) {
    return MESSAGE_TOO_LONG;
  }

  /* Allocate new memory and copy data to that memory. */
  *sz_mess = malloc(sizeof(char)*(LI*2 + 1));

  assert(*sz_mess);
  memcpy(*sz_mess, sz_buff, strlen(sz_buff)*sizeof(char)+1);
  assert(strlen(*sz_mess) == strlen(sz_buff));


  /* Read the rest of the hex-number from the file and put them in sz_buff2. */
  while (strlen(*sz_mess) < LI*2) {
    /* if (readline(fp, &(*sz_mess[strlen(*sz_mess)]), (LI*2 + 1) - strlen(*sz_mess))) { */
    if (readline(fp, sz_buff, BIG_BUFF_SIZE)) {
      free(*sz_mess);
      return MESSAGE_TOO_SHORT;
    }
    sscanf(sz_buff, "%s", sz_buff);
    if (strlen(sz_buff) + strlen(*sz_mess) > LI*2) {
      free(*sz_mess);
      return MESSAGE_TOO_LONG;
    }
    sscanf(sz_buff, "%s",  (*sz_mess)+strlen(*sz_mess) );
  }
  
  /* Check if sz_mess contains illegal characters. */
  if (strspn(*sz_mess, legal) != strlen(*sz_mess)) {
    free(*sz_mess);
    return MESSAGE_IS_ILLEGAL;
  }
  /* Check the length of the message. */
  if (strlen(*sz_mess) < LI*2-8) {
    free(*sz_mess);
    return MESSAGE_TOO_SHORT;
  }
  return 0;
}

int main(int argc, char *argv[]) {
  FILE *fp_input; /* The input file. */
  FILE* fp_ex = NULL; /* The the executeble output file. */
  unsigned int options = 0; /* Command line options. */
  int errflag = 0;
  char *sz_mess; /* The \0 terminated string containing message as ascii. */
  char *sz_ofile = NULL;
  char arg;
  BOOL b_isAnswer;

  /* For getopt(). */
  extern char *optarg;
  extern int optind;

  /* Handle command line options. */
  while ((arg = getopt(argc, argv, "vtrbihdsxo:?")) != EOF) {
    switch (arg) {
    case 'v':
      options = options | OPT_VERBOSE;
      break;
    case 't':
      options = options | OPT_SHOW_TIMESTAMP;
      break;
    case 'b':
      options = options | (OPT_SHOW_RANGE_BITS | OPT_SHOW_RANGE);
      break;
    case 'r':
      options = options | OPT_SHOW_RANGE;
      break;
    case 'i':
      options = options | OPT_SHOW_INFORMATION;
      break;
    case 'h':
      options = options | OPT_SHOW_HEX;
      break;
    case 'd':
      options = options | OPT_SHOW_DIRECTION;
      break;
    case 's':
      options = options | OPT_INPUT_STDIN;
      break;
    case 'x':
      options = options | OPT_XTERM;
      break;
    case 'o':
      sz_ofile = optarg;
      options = options | OPT_OUTPUT_EXEC;
      break;
     case '?':
      ++errflag;
      break;
    default:
      fprintf(stderr, "Unknown option: -%c\n", arg);
      ++errflag;
      break;
    }
  }

  /* optind will be one less if -s is used. */
  if (errflag || optind+1-(!!(options & OPT_INPUT_STDIN)) != argc) {
    fprintf(stderr, "A CP-DP message translator. (Interpret CP/DP message)\n");
    fprintf(stderr, "usage: %s [options] [file.log]\n\n", argv[0]);
    fprintf(stderr, "OUTPUT OPTIONS:\n");
    fprintf(stderr, "\t-t: Display timestamp for the message.\n");
    fprintf(stderr, "\t-r: Display bit range for each field in the message.\n");
    fprintf(stderr, "\t-b: Display range in bits instead of byte:bit.\n");
    fprintf(stderr, "\t-i: Display detailed information about the field.\n");
    fprintf(stderr, "\t-h: Show field value in hex.\n");
    fprintf(stderr, "\t-d: Show the direction of the message.\n");
    fprintf(stderr, "\t-v: Verbose, same as: -trihd\n");
    fprintf(stderr, "\t-x: Print output specialized for XTerm. (fancy bold text)\n");
    fprintf(stderr, "\t-o file: Output executable code to file.\n\n");
    fprintf(stderr, "INPUT OPTIONS:\n");
    fprintf(stderr, "\t-s: Read input from stdin instead of reading from a file.\n");
    fprintf(stderr, "\t    Program can be executed with:\n");
    fprintf(stderr, "\t     cat file.log | %s -s\n\t    or\n\t     %s -s < file.log\n\n", argv[0], argv[0]);
    fprintf(stderr, "OTHER OPTIONS:\n\t-?: Display this message. This options seems buggy in tcsh but works fine in bash.\n");
    return -1;
  }
  
  /* Set the fp_input to a file or to stdin depending on the -s flag. */
  if (options & OPT_INPUT_STDIN) {
    printf("Reading input from stdin, quit by pressing ^D. (Control-D)\n");
    fp_input = stdin;
  }
  else {
    fp_input = fopen(argv[optind], "r");
    if (!fp_input) {
      printf("unable to open %s, quitting!\n", argv[1]);
      return -1;
    }
  }

  /* Read the messages. */
  for (;;) {
    struct message mess = {0, 0, 0};
    char c;
    char sz_appName[SMALL_BUFF_SIZE];
    char sz_buff[SMALL_BUFF_SIZE];
    int i;

    /* Match the header of a message, header has form: */
    /* <- dpCh:        ID=[3,1] L=94 H=0x052e  Wed Jun 21 17:44:12 2023 */
    if (fwd_to(fp_input, "<{0,1}->{0,1}\\ *\t*[a-zA-Z]+:\\ *\t*ID=\\[[0-9]+,[0-9]+\\]\\ *\t*\\ *L=[0-9]+\\ *\t*\\ *H=0x", SET_FP_BEFORE)) {
      printf("End of messages.\n");
      break;
    }
    /* Read all the "headers" for the message. */
    fscanf(fp_input, "%c", &c); /* Direction */
    fscanf(fp_input, "%c", &c); /* Direction */
    b_isAnswer = (c == '-'); /* since -> means question and <- means answer. */

    fscanf(fp_input, "%s", sz_appName); /* Application name. */
    sz_appName[strlen(sz_appName)-1] = '\0'; /* Appname will contain a colon which we don't want. */
    fscanf(fp_input, "%s %s %s", sz_buff, sz_buff, sz_buff); /* Just some trash... */

    /* Read in the date string. */
    bzero(sz_buff, SMALL_BUFF_SIZE);
    for (i = 0; i < 5; ++i) {
      fscanf(fp_input, "%s", &(sz_buff[strlen(sz_buff)]) );
      sz_buff[strlen(sz_buff)] = ' ';
    }
    sz_buff[strlen(sz_buff)-1] = '\0';

    /* Read the header, now read the message itself. */
    switch (read_message(fp_input, &sz_mess)) {
    case MESSAGE_TOO_SHORT:
      if (strlen(sz_mess) == 0) {
	fclose(fp_input);
	return 0;
      }
      fprintf(stderr, "The message is shorter than what what the LI field says, skipping that one.\n");
      continue;
    case MESSAGE_TOO_LONG:
      fprintf(stderr, "The message is longer than what the LI field says, skipping that one.\n");
      continue;
    case MESSAGE_IS_ILLEGAL:
      fprintf(stderr, "The message contains illegal characters, skipping that one.\n");
      continue;
    }

    convert_message(sz_mess, &mess);

    /* Hack hack... fix the AC-field... */
    mess.AC = mess.AC & 0xff;

    interpret(sz_appName, b_isAnswer, &mess, options, sz_ofile, (options & OPT_SHOW_TIMESTAMP ? sz_buff : NULL));

    
    free(mess.PA);
    free(sz_mess);
    printf("\n");
  }

  if (options & OPT_OUTPUT_EXEC)
    fclose(fp_ex);
  fclose(fp_input);
  return 0;
}
