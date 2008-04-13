PROJECT           = qgl-demo
TEMPLATE          = app
CONFIG           += qt opengl warn_on debug

OBJECTS_DIR       = obj
MOC_DIR           = moc

HEADERS           = map.hpp \
		    gamewidget.hpp \
		    mainwindow.hpp

SOURCES           = main.cpp \
		    gamewidget.cpp \
		    mainwindow.cpp

TARGET            = qgl-demo
