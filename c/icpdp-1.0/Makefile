#########################################################################
# InterCpDp makefile.							#
# Global vaiables.							#
# Author: Tomas Mannerstedt 						#
# Date: Thu Jul 15 15:10:20 MEST 2004					#
# Contact: tomasm@linux.nu						#
#									#
# Note: CONFDIR is probably the only variable that has to be set up.	#
#									#
# Change the path to the configfile (CONFDIR) to match the place where	#
# you have placed							#
# the files in ./etc							#
# (Ususlly: /path/to/where/you/untared/icpdp/etc/)

CONFDIR=\"`pwd`/etc/\"

# Just the name of the temporary directory used by build_index.		#
TEMPDIR=\"/tmp/InterCpDp/\"

# The post command used to post executable output.			#
POST_CMD=\"/dpc/p/post\"

# Add -DNO_INDEX_FILES to CFLAGSif you want to disable use of index	#
# files. This may be slow if configuration files are large.		#
CFLAGS=-O2 -Wall -pedantic -DCONFDIR=$(CONFDIR) -DPOST_CMD=$(POST_CMD)\
	-DTEMPDIR=$(TEMPDIR) # -DNO_INDEX_FILES

# Some other variables, you probably don't have to change thease.	#
BINDIR=./bin/
CC=gcc
SRC=./src/
INC=./include/

# End of varaibles.							#
#									#
# Global make rules.							#
all : icpdp build_index

clean :
	-rm $(BINDIR)icpdp $(BINDIR)build_index $(SRC)*.o $(SRC)*~ $(INC)*~ *~

# make rules for icpdp.							#
ICPDPOBJS=$(SRC)bit_fun.o $(SRC)file_fun.o $(SRC)icpdp.o $(SRC)interpreter.o

icpdp : $(ICPDPOBJS)
	$(CC) $(CFLAGS) -o $(BINDIR)icpdp $(ICPDPOBJS)

icpdp.o : $(SRC)icpdp.c
	$(CC) $(CFLAGS) -c $(SRC)icpdp.c

bit_fun.o : $(SRC)bit_fun.c
	$(CC) $(CFLAGS) -c $(SRC)bit_fun.c

interpreter.o : $(SRC)interpreter.c
	$(CC) $(CFLAGS) -c $(SRC)interpreter.c

# make rules for build_index.						#
BUILD_INDEXOBJS=$(SRC)build_index.o $(SRC)file_fun.o

build_index : $(BUILD_INDEXOBJS)
	$(CC) $(CFLAGS) -o $(BINDIR)build_index $(BUILD_INDEXOBJS)

build_index.o : $(SRC)build_index.c
	$(CC) $(CFLAGS) -c $(SRC)build_index.c

file_fun.o : $(SRC)file_fun.c
	$(CC) $(CFLAGS) -c $(SRC)file_fun.c

# Done									#
#########################################################################
