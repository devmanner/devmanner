CC	= gcc -Wall -DUNIX -I../inc/

all: test

test: intset.o test.o
	$(CC) -o $@ intset.o test.o -lm

%.o: %.c
	$(CC) -c -o $@ $<

clean:
	rm -f *.o test *~
