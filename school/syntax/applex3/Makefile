# Project: applex3
# Makefile created by Dev-C++ 4.9.8.0

CPP  = g++
CC   = gcc
WINDRES = windres.exe
RES  = 
OBJ  = casio.o lexer.o 
LIBS =  -lfl
BIN  = applex3.exe
CXXFLAGS = $(CXXINCS) 
CFLAGS = $(INCS) 

.PHONY: all all-before all-after clean clean-custom

all: all-before applex3.exe all-after


clean: clean-custom
	rm -f $(OBJ) $(BIN) lex.yy.c lex.yy.o

$(BIN): casio.o lexer.o lex.yy.o
	$(CPP) casio.o lexer.o lex.yy.o -o "applex3.exe" $(LIBS)

casio.o: casio.c
	$(CPP) -c casio.c -o casio.o $(CXXFLAGS)

lexer.o: lexer.c
	$(CPP) -c lexer.c -o lexer.o $(CXXFLAGS)

lex.yy.o: lex.yy.c
	$(CPP) -c lex.yy.c -o lex.yy.o $(CXXFLAGS)

lex.yy.c: calculator.l
	flex calculator.l
