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
    ogl.setBaseSize(640, 480);
    a.setMainWidget( &ogl );

    if (argc > 1)
      ogl.showFullScreen();
    else
      ogl.show();
   
    return a.exec();
}

