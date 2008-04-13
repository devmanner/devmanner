#include <qapplication.h>
#include <qgl.h>
#include "MyOpenGLWidget.h"

int main( int argc, char **argv ) {
    QApplication::setColorSpec( QApplication::CustomColor );
    QApplication a(argc,argv);

    if ( !QGLFormat::hasOpenGL() ) {
	qWarning( "This system has no OpenGL support. Exiting." );
	return -1;
    }
    
    MyOpenGLWidget ogl; 
    a.setMainWidget( &ogl );
    ogl.show();
   
    return a.exec();
}

