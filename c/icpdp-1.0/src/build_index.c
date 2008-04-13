#include <stdio.h>

#ifdef NO_INDEX_FILES
int main() {
  fprintf(stderr, "The icpdp package was built without index file support, this program does nothing!\n");
  return 0;
}

#else

#include <dirent.h>
#include <libgen.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <errno.h>

#include "../include/file_fun.h"
#include "../include/options.h"
#include "../include/limits.h"

#define MAX_AC 128
#define UNUSED ~0

/* Some return codes. */
#define CANNOT_CREATE_INDEX_FILE -1
#define CANNOT_OPEN_CONF_FILE -2


extern int errno;

static int build_index(const char *sz_dir, const char *sz_fname, unsigned int options) {
  struct pair {
    long int question;
    long int answer;
  };
  char sz_buff[BIG_BUFF_SIZE];
  FILE *fp;
  char *p_regexpAnswer;
  char *p_regexpQuestion;
  long fpos;
  struct pair positions[MAX_AC];
  int i;

  /* Set all positions to unused. */
  for (i = 0; i < MAX_AC; ++i)
    positions[i].answer = positions[i].question = UNUSED;
  
  /* Open, read and parse input file. Fill the positions array. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "%s/%s", sz_dir, sz_fname);
  if ( !(fp = fopen(sz_buff, "r")) ) {
    return CANNOT_OPEN_CONF_FILE;
  }

  /* Regular expression matching an AC-field. */
  p_regexpAnswer = regcmp("^ANSWER\\ *:\\ *AC\\ *:\\ 0x.*\\ *:\\ *.*", (char*) 0);
  p_regexpQuestion = regcmp("^QUESTION\\ *:\\ *AC\\ *:\\ 0x.*\\ *:\\ *.*", (char*) 0);

  fpos = ftell(fp);
  while (!readline(fp, sz_buff, BIG_BUFF_SIZE)) {
    /* Did we find an question AC-field? */
    if (regex(p_regexpQuestion , sz_buff)) {
      unsigned int readAC;
      sscanf(sz_buff, "QUESTION: AC : 0x%x", &readAC);
      if (options & OPT_VERBOSE)
	printf("read AC: 0x%02x at pos: %ld\n", readAC, fpos);
      if (positions[readAC].question == UNUSED || positions[readAC].question > fpos)
	positions[readAC].question = fpos;
    }
    /* Or a answer AC-field? */
    if (regex(p_regexpAnswer , sz_buff)) {
      unsigned int readAC;
      sscanf(sz_buff, "ANSWER: AC : 0x%x", &readAC);
      if (options & OPT_VERBOSE)
	printf("read AC: 0x%02x at pos: %ld\n", readAC, fpos);
      if (positions[readAC].answer == UNUSED || positions[readAC].answer > fpos)
	positions[readAC].answer = fpos;
    }
    fpos = ftell(fp);
  }
  free(p_regexpAnswer);
  free(p_regexpQuestion);
  fclose(fp);
  /* Done filling positions array. */

  /* Print positions file to output. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "%s/%s.index", TEMPDIR, sz_fname);
  if ( !(fp = fopen(sz_buff, "w")) ) {
    return CANNOT_CREATE_INDEX_FILE;
  }

  for (i = 0; i < MAX_AC; ++i) {
    if (positions[i].answer != UNUSED)
      fprintf(fp, "ANSWER: 0x%02x:%ld\n", i, positions[i].answer);
    if (positions[i].question != UNUSED)
      fprintf(fp, "QUESTION: 0x%02x:%ld\n", i, positions[i].question);
  }
  
  fclose(fp);
  return 0;
}


int main(int argc, char *argv[]) {
  DIR *dirp = opendir(CONFDIR);
  char *p_regexp;
  unsigned int options = 0;
  char arg;
  int errflag = 0;

  /* For getopt(). */
  /* extern char *optarg; */
  extern int optind;

  /* Handle command line options. */
  while ((arg = getopt(argc, argv, "v?")) != EOF) {
    switch (arg) {
    case 'v':
      options = options | OPT_VERBOSE;
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

  /* Quit and print help message. */
  if (errflag) {
    fprintf(stderr, "A program used to build the index files for searching the config files. This program has to be run once after each change of a .conf file.\n");
    fprintf(stderr, "usage: %s [-v]\n", argv[0]);
    fprintf(stderr, "\nOUTPUT OPTIONS:\n\t-v: Run program in verbose mode.\nOTHER OPTIONS:\n\t-?: Display this message.\n\n");
    return -1;
  }

  /* Creating directory for output. */
  /* Setting chmod to 755 (rwxr-xr-x) */
  if (mkdir(TEMPDIR, S_IRWXU | S_IRWXG | S_IRWXO) == -1) {
    if (errno != EEXIST) {
      fprintf(stderr, "Could not create directory for indexfile output: %s quitting!\n", TEMPDIR);
      return -1;
    }
  }

  if (options & OPT_VERBOSE)
    printf("Building index-files for .conf files in: %s\nThe index-files will be placed in: %s\n", CONFDIR, TEMPDIR);
  if (!dirp) {
    fprintf(stderr, "Cannot open directory: %s.\n", CONFDIR);
    return -1;
  }
  
  /* The regular expression for a .conf file. */
  p_regexp = regcmp("^.*\\.conf$", (char*) 0);
  while (dirp) {
    struct dirent *dp;
    if ((dp = readdir(dirp)) != NULL) {
      /* Did we find a .conf file? */
      if (regex(p_regexp , dp->d_name)) {
	if (options & OPT_VERBOSE)
	  printf("Building index for: \"%s\" \n", dp->d_name);
	switch (build_index(CONFDIR, dp->d_name, options)) {
	case  CANNOT_CREATE_INDEX_FILE:
	  fprintf(stderr, "Cannot create index file for: %s, quitting!\nTip: Check the permissions of: %s\n", dp->d_name, TEMPDIR);
	  free(p_regexp);
	  closedir(dirp);
	  return -1;
	  break;
	case CANNOT_OPEN_CONF_FILE:
	  fprintf(stderr, "Cannot open config file: %s, quitting!\n", dp->d_name);
	  free(p_regexp);
	  closedir(dirp);
	  return -1;	  
	  break;
	default:
	  break;
	}
	if (options & OPT_VERBOSE)
	  printf("done with: \"%s\"\n", dp->d_name);
      }
      else {
	if (options & OPT_VERBOSE)
	  printf("Skipping \"%s\"\n", dp->d_name);
      }
    }
    else {
      /* End of directory. */
      break;
    }
  }
  
  if (options & OPT_VERBOSE)
    printf("All index files are now up to date.\n");
  
  free(p_regexp);
  closedir(dirp);
  return 0;
}

#endif /* NO_INDEX_FILES */
