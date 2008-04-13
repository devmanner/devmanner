TEMPLATE	= app
CONFIG		+= qt opengl warn_on release
HEADERS		= MyOpenGLWidget.h
SOURCES		= MyOpenGLWidget.cpp\
		  main.cpp
TARGET		= test
DEPENDPATH	= ../include
OBJECTS_DIR	= obj
MOC_DIR		= moc
