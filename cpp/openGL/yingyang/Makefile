#############################################################################
# Makefile for building: yingyang
# Generated by qmake (1.05a) (Qt 3.1.2) on: Sat Oct 18 18:26:05 2003
# Project:  yingyang.pro
# Template: app
# Command: $(QMAKE) -o Makefile yingyang.pro
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
INCPATH  = -I$(QTDIR)/mkspecs/default -I. -I. -I$(QTDIR)/include -I/usr/X11R6/include -I/usr/X11R6/include
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

OBJECTS_DIR = ./

####### Files

HEADERS = MyOpenGLWidget.h
SOURCES = main.cpp \
		MyOpenGLWidget.cpp
OBJECTS = main.o \
		MyOpenGLWidget.o
FORMS = 
UICDECLS = 
UICIMPLS = 
SRCMOC   = moc_MyOpenGLWidget.cpp
OBJMOC = moc_MyOpenGLWidget.o
DIST	   = yingyang.pro
QMAKE_TARGET = yingyang
DESTDIR  = 
TARGET   = yingyang

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

Makefile: yingyang.pro  $(QTDIR)/mkspecs/default/qmake.conf 
	$(QMAKE) -o Makefile yingyang.pro
qmake: 
	@$(QMAKE) -o Makefile yingyang.pro

dist: 
	@mkdir -p .tmp/yingyang && $(COPY_FILE) --parents $(SOURCES) $(HEADERS) $(FORMS) $(DIST) .tmp/yingyang/ && ( cd `dirname .tmp/yingyang` && $(TAR) yingyang.tar yingyang && $(GZIP) yingyang.tar ) && $(MOVE) `dirname .tmp/yingyang`/yingyang.tar.gz . && $(DEL_FILE) -r .tmp/yingyang

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

main.o: main.cpp MyOpenGLWidget.h

MyOpenGLWidget.o: MyOpenGLWidget.cpp MyOpenGLWidget.h

moc_MyOpenGLWidget.o: moc_MyOpenGLWidget.cpp MyOpenGLWidget.h 

moc_MyOpenGLWidget.cpp: $(MOC) MyOpenGLWidget.h
	$(MOC) MyOpenGLWidget.h -o moc_MyOpenGLWidget.cpp

####### Install

install: all 

uninstall: 

