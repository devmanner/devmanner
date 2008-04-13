#include "../include/file_fun.h"
#include "../include/limits.h"


int readline(FILE* fp, char* dest, size_t max) {
  int ret = (fgets(dest, max, fp) ? 0 : -1);
  dest[strlen(dest)-1] = '\0';
  return ret;
}



int fwd_to(FILE *fp, char *sz_regexp, int setpos) {
  char sz_buff[BIG_BUFF_SIZE];
  long fpos = ftell(fp);
  long startpos = fpos;
  char *p_regexp = regcmp(sz_regexp, (char*) 0);
  char *p_pos;
  extern char *__loc1;
  if (!p_regexp)
    return -2;
  
  while (!readline(fp, sz_buff, BIG_BUFF_SIZE)) {
    if ( (p_pos = regex(p_regexp, sz_buff)) ) {
      if (fp == stdin) {
	char *p = sz_buff + strlen(sz_buff)-1;
	char *p_end = (setpos == SET_FP_AFTER) ? p_pos : __loc1;
	ungetc('\n', fp);
	while (p >= p_end) {
	  ungetc(*p, fp);
	  --p;
	}
      }
      else {
	fseek(fp, fpos + ( ((setpos == SET_FP_BEFORE) ? __loc1 : p_pos) - sz_buff ), SEEK_SET);
      }
      return 0;
    }
    fpos = ftell(fp);
  }
  fseek(fp, startpos, SEEK_SET);
  return -1;
}

