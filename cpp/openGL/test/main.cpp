#include <qapplication.h>
#include <qgl.h>
#include "globjwin.h"

int main(int argc, char *argv[]) {
  QApplication::setColorSpec( QApplication::CustomColor );
  QApplication app(argc, argv);

  if ( !QGLFormat::hasOpenGL() ) {
    qWarning( "This system has no OpenGL support. Exiting." );
    return -1;
  }

  GLObjectWindow win;
  win.resize( 550, 350 );
  app.setMainWidget( &win );
  win.show();
  
  return app.exec();
}
