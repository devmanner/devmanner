CC	= gcc
MY_INC	= -I../inc/
BIN	= before_main debuginfo_test exception_test

all: $(BIN)

before_main: before_main.c
	$(CC) -Wall -o $@ $<

debuginfo_test: debuginfo_test.c ../inc/debuginfo.h
	$(CC) -Wall $(MY_INC) -o $@ debuginfo_test.c

exception_test: exception_test.c ../inc/exception.h
	$(CC) -Wall $(MY_INC) -o $@ exception_test.c


clean:
	rm -f $(BIN) *~
