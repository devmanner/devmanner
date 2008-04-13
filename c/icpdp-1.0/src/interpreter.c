#include "../include/interpreter.h"

/*#define DEBUG_MODE*/
#include "../include/debuginfo.h"

#ifdef NO_INDEX_FILES
/*
 * A "dummy" implementation of the find_startpos if NO_INDEX_FILES is defined.
 */
static long int find_startpos(const char *sz_appName, UTWOBYTE AC, BOOL b_isAnswer) {
  return 0;
}

/* Just print out a warning when icpdp is built without index file support. */
#ifdef __GNUC__
#warning "The icpdp is being built without index file support." 
#else
#pragma WARNING("The icpdp is being built without index file support.")
#endif


#else
/*
 * Find the starting position of a message in its config file by searching in the index file.
 * Return values:
 * -1 => AC is not found in the index file.
 * >= 0 => AC was found in the index file and the position in the config file is returned.
 */
static long int find_startpos(const char *sz_appName, UTWOBYTE AC, BOOL b_isAnswer) {
  char sz_buff[MEDIUM_BUFF_SIZE];
  FILE *fp;
  long int fpos;
  unsigned int realAC = (unsigned int) AC;
  int ret;

  snprintf(sz_buff, MEDIUM_BUFF_SIZE, "%s/%s.conf.index", TEMPDIR, sz_appName);
  fp = fopen(sz_buff, "r");
  if (!fp) {
    fprintf(stderr, "Cannot open indexfile: %s\nDid you really build it?\n", sz_buff);
    return -2;
  }

  if (b_isAnswer)
    snprintf(sz_buff, MEDIUM_BUFF_SIZE, "^ANSWER:\\ +0x%02x:", realAC);
  else 
    snprintf(sz_buff, MEDIUM_BUFF_SIZE, "^QUESTION:\\ +0x%02x:", realAC);

  ret = fwd_to(fp, sz_buff, SET_FP_AFTER);
  assert(ret != -2); /* The regular expression shall never be invalid. */
  
  if (ret) {
    fclose (fp);
    return -1;
  }
  fscanf(fp, "%ld", &fpos);
  fclose(fp);
  return fpos;
}
#endif /* NO_INDEX_FILES  */


/*
 * Print an IPv4 address given as a 4 byte integer.
 */
static void print_ipaddr(UFOURBYTE addr) {
  union { UFOURBYTE m1; UBYTE m2[4]; } foo;
  foo.m1 = addr;
  printf("%u.%u.%u.%u", foo.m2[0], foo.m2[1], foo.m2[2], foo.m2[3]);
}


/*
 * Print a ASCII string from a 4 byte integer.
 */
static void print_ascii(UFOURBYTE x) {
  union { UFOURBYTE m1; UBYTE m2[4]; } foo;
  foo.m1 = x;
  printf("%c%c%c%c", foo.m2[0], foo.m2[1], foo.m2[2], foo.m2[3]);
}

/*
 * Replace the first occurance of '#' with '\0' in sz_buff.
 */
static void strip_comments(char* sz_buff) {
  char *p = strchr(sz_buff, '#');
  if (p)
    *p = '\0';
}


/* 
 * Check if a string is empty eg. only contains \w and \t.
 * Return value:
 * 1 => String is empty.
 * 0 => String is not empty.
 */
static int is_empty(char *c) {
  assert(c);
  if (*c) {
    while (*c == ' ' || *c == '\t') {
      if (!*(++c))
	return 1;
    }
    return 0;
  }
  return 1;
}


/*
 * Get a range on form bit to bit from "bit-bit", "bit", byte:bit-byte:bit" or "byte:bit".
 * Return value: A pointer to a struct containing the range.
 */
static struct range* get_range(char* sz_range) {
  static struct range range = {-1, -1};
  char * p_regexp;
  
  /* Set the range to invalid! */
  range.start = -1;
  range.stop = -1;

  /* Check if one bit or a bit-range. */
  /* A range on the form bit-bit. */
  assert(p_regexp = regcmp("^[0-9]*-[0-9] *", (char*) 0));
  if (regex(p_regexp, sz_range)) {
    sscanf(sz_range, "%d-%d", &(range.start), &(range.stop));
  }
  else {
    free(p_regexp);
    /* A range on the form byte:bit-byte:bit. */
    assert(p_regexp = regcmp("^[0-9]*:[0-9]*-[0-9]*:[0-9] *", (char*) 0));
    if (regex(p_regexp, sz_range)) {
      int startByte, startBit, stopByte, stopBit;
      sscanf(sz_range, "%d:%d-%d:%d", &startByte, &startBit, &stopByte, &stopBit);
      range.start = ((startByte-1) << 3) + startBit;
      range.stop = ((stopByte-1) << 3) + stopBit;
    }
    else {
      free(p_regexp);
      /* A range on the form byte:bit */
      assert(p_regexp = regcmp("^[0-9]*:[0-9]* *", (char*) 0));
      if (regex(p_regexp, sz_range)) {
	int byte, bit;
	sscanf(sz_range, "%d:%d", &byte, &bit);
	range.start = range.stop = ((byte-1) << 3) + bit;
      }    
      else {
	free(p_regexp);
	assert(p_regexp = regcmp("^[0-9]* *", (char*) 0));
	if (regex(p_regexp, sz_range)) {
	  sscanf(sz_range, "%d", &(range.start));
	  range.stop = range.start;
	}
	else {
	  /* Here we have an error but we don't do anything since it's already taken care of. */
	}
      }
    }
  }
  free(p_regexp);
  if (range.start > range.stop)
    range.start = range.stop = -1;
  return &range;
}

/*
 * Print a field.
 */
static int print_field(struct range *range, char *sz_name, char *sz_type, char *sz_value, char *sz_message, struct message *mess, int options) {
  UFOURBYTE data;
  
  /* Get the bit range (startPos:stopPos) from PA. */
  if (!strcmp(sz_type, "BIT"))
    data = get_bit(&(mess->PA[range->start >> 3]), range->start & 7); /* >> 3 is / 3 and & 7 is % 8 if you're unaware... */
  else 
    data = get_bit_range4(mess->PA, range->start, range->stop);
  
  /* Don't print out the field if it is an empty field or the value does not match the read value. */
  if (strcmp("*", sz_value) && atoi(sz_value) != data) {
    return 0;
  }
  
  /* Display the output. */
  if (options & OPT_SHOW_RANGE) {
    if (options & OPT_SHOW_RANGE_BITS)
      printf("bit: %d to %d\t", range->start, range->stop);
    else /* Add one because the bytes are not 0-counted. (first byte is 1) */
      printf("%d:%d to %d:%d\t", ((range->start) >> 3) + 1, (range->start) & 0x7, ((range->stop) >> 3) + 1, (range->stop) & 0x7);
  }
  
  /* Default output. Print the name right aligned with 20 characters. */
  printf("%25s: ", sz_name);      
  /* Here more special typeas can be added, like MAC-adress or something. */
  if (!strcmp(sz_type, "IP_ADDR"))
    print_ipaddr(data);
  else if (!strcmp(sz_type, "ASCII"))
    print_ascii(data);
  else
    printf("%d", data);
  printf(" ");
  
  if (options & OPT_SHOW_HEX)
    printf("(0x%x) ", data);
  if (options & OPT_SHOW_INFORMATION)
    printf("%s", sz_message);
  
  printf("\n");
  return 0;
}

static void print_exec(const char *sz_ofile, const char *sz_appName, const struct message *mess) {
  static FILE *fp_ex = NULL;
  FILE* fp_conf;
  long int fpos;
  char sz_buff[BIG_BUFF_SIZE];
  size_t fixed=0, variable=0;

  /* Get the start position. */
  fpos = find_startpos(sz_appName, mess->AC, FALSE);
  if (fpos < 0)
    fpos = 0;

  /* Get the name of the appropriate config file and open it. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "%s/%s.conf", CONFDIR, sz_appName);
  fp_conf = fopen(sz_buff, "r");
  if (!fp_conf) {
    fprintf(stderr, "Cannot find config file: %s\n", sz_buff);
    return;
  }

  /* Seek to the starting position. */
  fseek(fp_conf, fpos, SEEK_SET);

  /* Create the regular expression. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "^QUESTION\\ *:\\ AC\\ *:\\ *0x%02x\\ *:\\ *.*", mess->AC);
  /* Continue searching until we read in the correct AC value. */ 
  if (fwd_to(fp_conf, sz_buff, SET_FP_AFTER)) {
    return;
  }
 
  /* Start extracting the length of the fixed/unfixed size fields.  */
  for (;;) {
    struct range *range;
    char *sz_range, *sz_type;
    char *p_regexp;

    if (readline(fp_conf, sz_buff, BIG_BUFF_SIZE)) {
      break;
    }

    strip_comments(sz_buff);
    /* Are there any characters left to process after the stripping? */
    if (is_empty(sz_buff))
      continue;
    
    /* Check if we have reached the next Action code section, if so, break. */
    assert(p_regexp = regcmp("^[A-Z]+\\ *:\\ *AC\\ *:\\ *0x", (char*) 0));
    if (regex(p_regexp, sz_buff)) {
      free(p_regexp);
      break;
    }
    free(p_regexp);
    
    /* Find the different parts of the string. */
    sz_range = strtok(sz_buff, "\t");
    strtok(NULL, "\t");
    sz_type = strtok(NULL, "\t");
    
    /* Get the range. */
    range = get_range(sz_range);
    /* range is "x:y-*:*" */
    if (range->stop == -1)
      range->stop = mess->LI-4 - variable - fixed;
    
    /* Is the field a INSTANCE_TYPE field? */
    if (!strcmp("INSTANCE_DATA", sz_type))
      variable += (range->stop - range->start) + 1;
    else if (!strcmp("TUNNELED_SIZE", sz_type)) {
      fixed = (mess->LI-4) << 3;
      break;
    }
    else
      fixed += (range->stop - range->start) + 1;
  }

  fclose(fp_conf);

  fixed = fixed >> 3;
  variable = variable >> 3;

  /* Check if we're opening for the first time... */
  if (!fp_ex) {
    fp_ex = fopen(sz_ofile, "w");
  }
  else {
    fp_ex = fopen(sz_ofile, "a+");
  }
  if (!fp_ex) {
    fprintf(stderr, "Cannot open %s for output\n", sz_ofile);
    return;
  }

  /* Print the output to the file. */
  if (variable) {
    int i, no_mess = (mess->LI - 4 - fixed) / variable;
    for (i = 0; i < no_mess; ++i) {
      int j;
      fprintf(fp_ex, "%s %s %04x%04x ", POST_CMD, sz_appName, mess->AC, 4 + fixed + variable);
      for (j = 0; j < fixed; ++j)
	fprintf(fp_ex, "%02x", mess->PA[j]);
      for (j = 0; j < variable; ++j)
	fprintf(fp_ex, "%02x", mess->PA[fixed + i*variable + j]);
    }
  }
  else {
    int i;
    fprintf(fp_ex, "%s %s %04x%04x ", POST_CMD, sz_appName, mess->AC, 4 + fixed + variable);
    for (i = 0; i < fixed; ++i)
      fprintf(fp_ex, "%02x", mess->PA[i]);
  }
  fprintf(fp_ex, "\n");

  fclose(fp_ex);
}


static struct interpret_reply *handle_instance_data(FILE* fp_conf, const long int fpos, struct message *mess, const int options) {
  static struct interpret_reply reply = {0, 0, 0};
  char sz_buff[BIG_BUFF_SIZE];
  struct range range = {0, 0};
  /* This variable holds the number of bits per INSTANCE_DATA block. */
  int bitsPerBlock = -1;
  int bitsThisBlock = 0;
  int handeledBlocks = 0;
  BOOL b_bytesLeft = 1;

  /* Set up the reply struct. */
  reply.error = reply.decoded_bytes = reply.tunneled_bytes = 0;

  /* Keep decoding until we run out of data. */
  while (b_bytesLeft) {
    fseek(fp_conf, fpos, SEEK_SET);
    /* While we have fields of type INSTANCE_DATA */
    for (;;) {
      char *sz_range, *sz_name, *sz_type, *sz_value, *sz_message;
      char *p_regexp;

      if (readline(fp_conf, sz_buff, BIG_BUFF_SIZE)) {
	break;
      }

      /* Check if we have reached the next Action code section, if so, break. */
      assert(p_regexp = regcmp("^[A-Z]+\\ *:\\ *AC\\ *:\\ *0x", (char*) 0));
      if (regex(p_regexp, sz_buff)) {
	free(p_regexp);
	break;
      }
      free(p_regexp);

      strip_comments(sz_buff);
      /* Is there any characters left to process after the stripping? */
      if (is_empty(sz_buff)) {
	continue;
      }
      
      /* Find the different parts of the string. */
      sz_range = strtok(sz_buff, "\t");
      sz_name = strtok(NULL, "\t");
      sz_type = strtok(NULL, "\t");
      sz_value = strtok(NULL, "\t");
      sz_message = strtok(NULL, "\t");
      if (!sz_message)
	sz_message = "";
      
      /* If not INSTANCE_DATA */
      if (strcmp("INSTANCE_DATA", sz_type))
	break;
      
      /* Extract the range. */
      range = *get_range(sz_range);

      /* Check that the range is legal. (>0) */
      if (range.start < 0 || range.stop < 0) {
	reply.error = ILLEGAL_RANGE;
	return &reply;
      }
      
      /* Do some calculation, this is needed for all kinds of fields (including EMPTY). */
      range.start = range.start + bitsPerBlock*handeledBlocks;
      range.stop = range.stop + bitsPerBlock*handeledBlocks;
      
      /* Skip the EMPTY fields. */
      if (strcmp(sz_name, "EMPTY")) {
	/* Check the range so it's not outside the size of the PA-field (LI-4), if so break so we can return. */
	if (range.stop/8 > (mess->LI-4)) {
	  b_bytesLeft = 0;
	  break;
	}
	print_field(&range, sz_name, sz_type, sz_value, sz_message, mess, options);
      }
      /* Increase the number of bits we have handeled. */
      bitsThisBlock += (range.stop - range.start) + 1;
    } /* End for(;;) */
    /* If bitsPerBlock is unset, HACK HACK... */
    if (bitsPerBlock == -1)
      bitsPerBlock = bitsThisBlock;
    ++handeledBlocks;
    bitsThisBlock = 0;
    reply.decoded_bytes = (bitsPerBlock*handeledBlocks) >> 3;
  } /* End while(data left) */
  return &reply;
}


/*
 * Interpret a message (mess) and return the number of bytes decoded or <0 if an error occured.
 */
static struct interpret_reply *interpret_submessage(const char *sz_appName, BOOL b_isAnswer, struct message *mess, const int options) {
  static struct interpret_reply reply;
  FILE* fp_conf;
  char sz_buff[BIG_BUFF_SIZE];
  char sz_funcName[MEDIUM_BUFF_SIZE];
  long int fpos;
  struct range *range = NULL;
  int i;
  char c;

  /* Setup the reply struct. */
  reply.error = reply.tunneled_bytes = reply.decoded_bytes = 0;

  /* Get the start position. */
  fpos = find_startpos(sz_appName, mess->AC, b_isAnswer);
  if (fpos) {
    if (fpos == -1)
      fprintf(stderr, "Cannot find AC: 0x%02x in the index file (for %s). Are you sure the index files are up to date? If not, run the build_index program. Forcing search, execution may be slow.\n", mess->AC, sz_appName);
    else if (fpos == -2)
      fprintf(stderr, "Cannot find index file, did you build it? Forcing search, execution may be slow.\n");
    fpos = 0;
  }
  
  /* Get the name of the appropriate config file and open it. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "%s/%s.conf", CONFDIR, sz_appName);
  fp_conf = fopen(sz_buff, "r");
  if (!fp_conf) {
    int i;
    fprintf(stderr, "Cannot find config file: %s\n", sz_buff);
    for (i = 0; i < mess->LI-4; ++i)
      printf("%02x", mess->PA[i]);
    printf("\n");
    reply.error = CONFIGFILE_NOT_FOUND;
    return &reply;
  }

  /* Seek to the starting position. */
  fseek(fp_conf, fpos, SEEK_SET);

  /* Create the regular expression. */
  snprintf(sz_buff, BIG_BUFF_SIZE, "^%sAC\\ *:\\ *0x%02x\\ *:\\ *", (b_isAnswer) ? "ANSWER: " : "QUESTION: ", mess->AC);
  /* Continue searching until we read in the correct AC value. */ 
  if (fwd_to(fp_conf, sz_buff, SET_FP_AFTER)) {
    reply.error = INTERR_AC_NOT_FOUND_IN_CONF_FILE;
    return &reply;
  }

  /* Read the function name and print it. */
  if (readline(fp_conf, sz_funcName, MEDIUM_BUFF_SIZE)) {
    reply.error = IO_ERROR;
    return &reply;
  }
  
  /* Display the rest of the message header. First, turn on bold text. (XTerm only...) */
  if (options & OPT_XTERM)
    printf("%c[1m", 27);
  /* Display the date if -t */
  printf("%s\t%s (AC: 0x%02x) LI: %d ", sz_appName, sz_funcName, mess->AC, mess->LI);
  if (options & OPT_SHOW_DIRECTION)
    printf("%s", (b_isAnswer) ? "Answer" : "Question");
  /* Turn off bold text. */
  if (options & OPT_XTERM)
    printf("%c[0m", 27);

  printf("\n");

  if (options & OPT_XTERM)
    printf("%c[1m", 27);
  c = b_isAnswer ? '<' : '>';
  for (i = 0; i < 80; ++i)
    putchar(c);
  printf("\n");
  if (options & OPT_XTERM)
    printf("%c[0m", 27);
  
  /* Start the interpretation of the message. Go through each line in the config file, extract */
  for (;;) {
    char *sz_range, *sz_name, *sz_type, *sz_value, *sz_message;
    char *p_regexp;

    fpos = ftell(fp_conf);
    if (readline(fp_conf, sz_buff, BIG_BUFF_SIZE)) {
      break;
    }

    strip_comments(sz_buff);
    /* Is there any characters left to process after the stripping? */
    if (is_empty(sz_buff))
      continue;
    
    /* Check if we have reached the next Action code section, if so, break. */
    assert(p_regexp = regcmp("^[A-Z]+\\ *:\\ *AC\\ *:\\ *0x", (char*) 0) );
    if (regex(p_regexp, sz_buff)) {
      free(p_regexp);
      break;
    }
    free(p_regexp);
    
    /* Find the different parts of the string. */
    sz_range = strtok(sz_buff, "\t");
    sz_name = strtok(NULL, "\t");
    /* Skip the EMPTY fields. */
    if (!strcmp(sz_name, "EMPTY"))
      continue;
    sz_type = strtok(NULL, "\t");
    sz_value = strtok(NULL, "\t");
    sz_message = strtok(NULL, "\t");
    if (!sz_message)
      sz_message = "";
    
    /* Get the range. */
    range = get_range(sz_range);
    /* Check that the range is legal. (>0) */
    if (range->start < 0 || range->stop < 0) {
      reply.error = ILLEGAL_RANGE;
      return &reply;
    }
    
    /* Check the range so it's not outside the size of the PA-field (LI-4). */
    if (range->stop >> 3 > (mess->LI-4)) {
      reply.error = UNMATCHED_SIZE;
      return &reply;
    }
    
    /* This is to handle "multiple instance data" */
    if (!strcmp("INSTANCE_DATA", sz_type)) {
      return handle_instance_data(fp_conf, fpos, mess, options);
    }
    /* Take care of the special stuff if we're dealing with a tunneled message. */
    else if (!strcmp(sz_type, "TUNNELED_SIZE")) {
      UFOURBYTE data = 0;
      if ( (reply.error = print_field(range, sz_name, sz_type, sz_value, sz_message, mess, options)) )
	return &reply;
      
      /* Get the bit range (startPos:stopPos) from PA. */
      data = get_bit_range4(mess->PA, range->start, range->stop);
      
      reply.tunneled_bytes = data;
      reply.decoded_bytes = ((range->stop+1) >> 3); /* That is number of decoded bits / 8 = number of decoded bytes. */
      fclose(fp_conf);
      return &reply;
    }
    /* Just a regular field. */
    else {
      if ( (reply.error = print_field(range, sz_name, sz_type, sz_value, sz_message, mess, options)) )
	return &reply;
    }
  } /* End for(;;) */
  fclose(fp_conf);

  if (range)
    reply.decoded_bytes = ((range->stop+1) << 3); /* That is number of decoded bits / 8 = number of decoded bytes. */
  else /* The message was empty and just contains a AC & LI field. */
    reply.decoded_bytes = 0;
  return &reply;
}


/*
 * Description: Print an error message for a specific error.
*/
static void print_interpret_error(const int error) {
  switch(error) {
  case INTERR_AC_NOT_FOUND_IN_CONF_FILE:
    fprintf(stderr, "AC_NOT_FOUND_IN_CONF_FILE\n");
    break;
  case CONFIGFILE_NOT_FOUND:
    fprintf(stderr, " CONFIGFILE_NOT_FOUND\n");
    break;
  case UNMATCHED_SIZE:
    fprintf(stderr, "UNMATCHED_SIZE\n");
    break;
  case IO_ERROR:
    fprintf(stderr, "IO_ERROR\n");
    break;
  case ILLEGAL_RANGE:
    fprintf(stderr, "ILLEGAL_RANGE\n");
    break;
  default:
    fprintf(stderr, "Unknown error code: %d\n", error);
    break;
  }
}



void interpret(const char *sz_appName, BOOL b_isAnswer, struct message *mess, const int options, const char *sz_ofile, const char *sz_date) {
  struct interpret_reply *reply;
  int i;

  if (options & OPT_XTERM)
    printf("%c[1m", 27);
  printf("\n");
  for (i = 0; i < 80; ++i)
    printf("%c", b_isAnswer ? '<' : '>');
  printf("\n%s ", (sz_date ? sz_date : "") );
  if (options & OPT_XTERM)
    printf("%c[0m", 27);
  
  reply = interpret_submessage(sz_appName, b_isAnswer, mess, options);

  if (options & OPT_OUTPUT_EXEC && !b_isAnswer) {
    print_exec(sz_ofile, sz_appName, mess);
  }
  
  if (reply->error) {
    print_interpret_error(reply->error);
    return; /* Return something intellegent??? */
  }
  /* Is the message tunneled? */
  else if (reply->tunneled_bytes) {
    unsigned int decBytes = reply->decoded_bytes;
    int toDecode = reply->tunneled_bytes;

    while (toDecode > 0) {
      char sz_buff[MEDIUM_BUFF_SIZE];
      FILE * fp_tunnel;
      struct message submess;
      struct interpret_reply *sub_reply;
      char c;
      UTWOBYTE DC = merge_2bytes(mess->PA[decBytes], mess->PA[decBytes+1]);
      /* The LI2 field is unused in the current implementation. The following line */
      /* describes how it can be extracted. */
      /* UFOURBYTE LI2 = merge_2bytes(mess->PA[decBytes+2], mess->PA[decBytes+3]); */ 
      submess.AC = merge_2bytes(mess->PA[decBytes+4], mess->PA[decBytes+5]);
      submess.LI = merge_2bytes(mess->PA[decBytes+6], mess->PA[decBytes+7]);

      /* Do this outside the loop and store the mapping between value and name. */
      snprintf(sz_buff, MEDIUM_BUFF_SIZE, "%s/%s", CONFDIR, "tunneling.spec");
      fp_tunnel = fopen(sz_buff, "r");
      if (!fp_tunnel) {
	fprintf(stderr, "Cannot open %s", sz_buff);
	return; /* Do something better!!! */
      }

      /* Search for the DC int the config file. */
      snprintf(sz_buff, MEDIUM_BUFF_SIZE, "^%d:", DC);
      if (fwd_to(fp_tunnel, sz_buff, SET_FP_AFTER)) {
	fprintf(stderr, "%d not registered as a tunneled message in: %s/%s\n", DC, CONFDIR, "tunneling.spec");
	return;
      }
      fscanf(fp_tunnel, "%s", sz_buff);

      /* I've decoded the DC, LI2, AC and LI field now, so decrease toDecode by 8. */
      toDecode -= 8;

      submess.PA = mess->PA+decBytes+8;
      printf("Tunneled part of the message:\n");

      if (options & OPT_XTERM)
	printf("%c[1m", 27);
      c = b_isAnswer ? '<' : '>';
      for (i = 0; i < 80; ++i)
	putchar(c);
      printf("\n");
      if (options & OPT_XTERM)
	printf("%c[0m\n", 27);
      
      sub_reply = interpret_submessage(sz_buff, b_isAnswer, &submess, options);

      if (sub_reply->error) {
	print_interpret_error(reply->error);
	return;
      }

      decBytes += sub_reply->decoded_bytes;
      toDecode-= submess.LI;
    }
  }
}
