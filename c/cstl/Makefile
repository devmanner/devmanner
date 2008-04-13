CC	= gcc
CFLAGS	= -Wall -I.
OBJ	= main.o


all: $(OBJ) vector.h
	$(CC) $(CFLAGS) -o test $(OBJ)


%.o: %.c
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f $(OBJ) *~ test


