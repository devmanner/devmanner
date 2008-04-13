#ifndef OPTIONS_H_INCLUDED
#define OPTIONS_H_INCLUDED

/* Output options. */
#define OPT_SHOW_TIMESTAMP 0x0001 /* -t Show timestamp. */
#define OPT_SHOW_RANGE 0x0002 /* -r Show field range. */
#define OPT_SHOW_INFORMATION 0x0004 /* -i Show extra information about the field. */
#define OPT_SHOW_HEX 0x0008 /* -h Show output as hexcode. */
#define OPT_SHOW_DIRECTION 0x0010 /* -d Show message direction. */
#define OPT_SHOW_RANGE_BITS 0x0020 /* -b Show range in bits instead of byte:bit. */
#define OPT_OUTPUT_EXEC 0x0040 /* -o file: Output executable code to file. */
#define OPT_XTERM 0x0080 /* -x Print XTerm specialized output. */

/* Input options. */
#define OPT_INPUT_STDIN 0x0100 /* -s Read input from stdin instead of a file. */

/* -v Verbose mode. */
#define OPT_VERBOSE (OPT_SHOW_TIMESTAMP | OPT_SHOW_RANGE | \
		     OPT_SHOW_INFORMATION | OPT_SHOW_HEX | \
		     OPT_SHOW_DIRECTION)

#endif
