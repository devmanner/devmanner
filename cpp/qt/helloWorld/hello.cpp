#include <qapplication.h>
#include <qpushbutton.h>

/*
Compile with:
g++ -o hello -Wall -I /usr/local/qt/include/ -lqt -L /usr/local/qt/lib/ hello.cpp
*/

int main( int argc, char **argv )
{
    QApplication a( argc, argv );

    QPushButton hello( "Hello world!", 0 );
    hello.resize( 100, 30 );

    a.setMainWidget( &hello );
    hello.show();
    return a.exec();
}
