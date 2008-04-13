
#include "mainwindow.hpp"
#include "gamewidget.hpp"

#include <qapplication.h>

#if defined(_CC_MSVC_)
#pragma warning(disable:4305) // init: truncation from const double to float
#endif


int main( int argc, char **argv )
{
    QApplication::setColorSpec( QApplication::CustomColor );
    QApplication a( argc, argv );

    if ( !QGLFormat::hasOpenGL() )
    {
        qWarning( "This system has no OpenGL support. Exiting." );
        return -1;
    }

    uint timer_interval = 10;
    if ( argc >= 2 )
    {
        bool ok = TRUE;
        timer_interval = QString::fromLatin1( argv[1] ).toInt( &ok );
        if ( !ok )
            timer_interval = 10;
    }

    MainWindow *mw = new MainWindow( timer_interval, 0, "MainWindow" );
    a.setMainWidget( mw );
    mw->show();

    int result = a.exec();

    a.setMainWidget( 0 );
    delete mw;
    return result;
}

