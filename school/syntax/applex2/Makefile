# Make-fil för applex 2 i Syntax.
# Komplettera tokens.l.
# Kompilera med make.
# Testkör med driver (eller driver < datafil).
#
# Förutsätter att du har laddat modulen gnu-make (detta
# sköts automatiskt om du har kört "course join syntax02").

CC		= gcc
CFLAGS		= -O2 -Wall
LEX		= flex
YACC		= bison
YFLAGS		= -d
LOADLIBES	= -lfl

driver: driver.o tokens.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LOADLIBES)

driver.o: driver.c symbol.h Makefile

tokens.o: tokens.c symbol.h Makefile
tokens.c: tokens.l Makefile

clean:
	rm -f driver driver.o tokens.o tokens.c core *~
