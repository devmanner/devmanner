#include <qapplication.h>
#include "lab1.h"


int main( int argc, char** argv )
{
	QApplication app( argc, argv );

	lab1_c window;
	app.setMainWidget(&window);

	window.show();

	return app.exec();
}

