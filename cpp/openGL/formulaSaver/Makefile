#############################################################################
# Makefile for building: formulaSaver
# Generated by qmake (1.05a) (Qt 3.1.2) on: Thu Jun 26 15:23:28 2003
# Project:  formulaSaver.pro
# Template: app
# Command: $(QMAKE) -o Makefile formulaSaver.pro
#############################################################################

####### Compiler, tools and options

CC       = gcc
CXX      = g++
LEX      = flex
YACC     = yacc
CFLAGS   = -pipe -Wall -W -O2  -DQT_NO_DEBUG
CXXFLAGS = -pipe -Wall -W -O2  -DQT_NO_DEBUG
LEXFLAGS = 
YACCFLAGS= -d
INCPATH  = -I$(QTDIR)/mkspecs/default -I. -I. -I$(QTDIR)/include -I/usr/X11R6/include -I/usr/X11R6/include -Imoc/
LINK     = g++
LFLAGS   = 
LIBS     = $(SUBLIBS)  -Wl,-rpath,$(QTDIR)/lib -L$(QTDIR)/lib -L/usr/X11R6/lib -L/usr/X11R6/lib -lqt-mt -lGLU -lGL -lXmu -lXext -lX11 -lm
AR       = ar cqs
RANLIB   = 
MOC      = $(QTDIR)/bin/moc
UIC      = $(QTDIR)/bin/uic
QMAKE    = qmake
TAR      = tar -cf
GZIP     = gzip -9f
COPY     = cp -f
COPY_FILE= $(COPY) -p
COPY_DIR = $(COPY) -pR
DEL_FILE = rm -f
SYMLINK  = ln -sf
DEL_DIR  = rmdir
MOVE     = mv -f
CHK_DIR_EXISTS= test -d
MKDIR    = mkdir -p

####### Output directory

OBJECTS_DIR = obj/

####### Files

HEADERS = FormulaShape.h \
		MyOpenGLWidget.h
SOURCES = MyOpenGLWidget.cpp \
		main.cpp
OBJECTS = obj/MyOpenGLWidget.o \
		obj/main.o
FORMS = 
UICDECLS = 
UICIMPLS = 
SRCMOC   = moc/moc_MyOpenGLWidget.cpp
OBJMOC = obj/moc_MyOpenGLWidget.o
DIST	   = formulaSaver.pro
QMAKE_TARGET = formulaSaver
DESTDIR  = 
TARGET   = formulaSaver

first: all
####### Implicit rules

.SUFFIXES: .c .cpp .cc .cxx .C

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.C.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.c.o:
	$(CC) -c $(CFLAGS) $(INCPATH) -o $@ $<

####### Build rules

all: Makefile $(TARGET)

$(TARGET):  $(UICDECLS) $(OBJECTS) $(OBJMOC) 
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJMOC) $(LIBS)

mocables: $(SRCMOC)

$(MOC): 
	( cd $(QTDIR)/src/moc ; $(MAKE) )

Makefile: formulaSaver.pro  $(QTDIR)/mkspecs/default/qmake.conf 
	$(QMAKE) -o Makefile formulaSaver.pro
qmake: 
	@$(QMAKE) -o Makefile formulaSaver.pro

dist: 
	@mkdir -p obj/formulaSaver && $(COPY_FILE) --parents $(SOURCES) $(HEADERS) $(FORMS) $(DIST) obj/formulaSaver/ && ( cd `dirname obj/formulaSaver` && $(TAR) formulaSaver.tar formulaSaver && $(GZIP) formulaSaver.tar ) && $(MOVE) `dirname obj/formulaSaver`/formulaSaver.tar.gz . && $(DEL_FILE) -r obj/formulaSaver

mocclean:
	-$(DEL_FILE) $(OBJMOC)
	-$(DEL_FILE) $(SRCMOC)

uiclean:

yaccclean:
lexclean:
clean: mocclean
	-$(DEL_FILE) $(OBJECTS) 
	-$(DEL_FILE) *~ core *.core


####### Sub-libraries

distclean: clean
	-$(DEL_FILE) $(TARGET) $(TARGET)


FORCE:

####### Compile

obj/MyOpenGLWidget.o: MyOpenGLWidget.cpp MyOpenGLWidget.h \
		FormulaShape.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o obj/MyOpenGLWidget.o MyOpenGLWidget.cpp

obj/main.o: main.cpp MyOpenGLWidget.h \
		FormulaShape.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o obj/main.o main.cpp

obj/moc_MyOpenGLWidget.o: moc/moc_MyOpenGLWidget.cpp MyOpenGLWidget.h FormulaShape.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o obj/moc_MyOpenGLWidget.o moc/moc_MyOpenGLWidget.cpp

moc/moc_MyOpenGLWidget.cpp: $(MOC) MyOpenGLWidget.h
	$(MOC) MyOpenGLWidget.h -o moc/moc_MyOpenGLWidget.cpp

####### Install

install: all 

uninstall: 

