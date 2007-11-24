# Project: MiniJava
# Makefile created by Dev-C++ 4.9.8.0 modified by Tomas Mannerstedt

CPP	= g++
CC	= gcc
YACC 	= bison -d
LEX	= flex

OBJ	= lex.yy.o parser.tab.o visitor.o
LINKOBJ	= lex.yy.o parser.tab.o visitor.o
LIBS	= -lfl

BIN  	= minijava
CXXFLAGS= -Wall 
CFLAGS 	= -Wall

DOCDIR	= doc/
DOXYFILE= Doxyfile
DOXYGEN	= doxygen
FILES	= BaseVisitor.hpp symbol_table.hpp types.hpp visitor.hpp btvt.hpp tcv.hpp visitor.cpp


.PHONY: all all-before all-after clean clean-custom

all: all-before minijava all-after

clean: clean-custom
	rm -f $(OBJ) $(BIN) parser.tab.c parser.tab.h lex.yy.cc

doc: $(DOCDIR)/html

$(DOCDIR)/html :
	pushd . && cd $(DOCDIR) && $(DOXYGEN) $(DOXYFILE) && popd

$(BIN): $(LINKOBJ)
	$(CPP) $(LINKOBJ) -o $(BIN) $(LIBS)

lex.yy.o: lex.yy.cc parser.tab.c
	$(CPP) -c lex.yy.c -o lex.yy.o $(CXXFLAGS)

parser.tab.o: parser.tab.c
	$(CPP) -c parser.tab.c -o parser.tab.o $(CXXFLAGS)

visitor.o: visitor.cpp
	$(CPP) -c visitor.cpp -o visitor.o $(CXXFLAGS)

parser.tab.c: lex.yy.c
	$(YACC) parser.y

lex.yy.cc: 
	$(LEX) scanner.l
