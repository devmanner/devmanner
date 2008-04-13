#include <qapplication.h>
#include <windows.h>
#include "qtGUI/optionswindow.h"
#include "cutterlib.h"
#include <string>

int main( int argc, char** argv ){
	QApplication app( argc, argv );

	optionsWindow window;
	app.setMainWidget(&window);

	window.show();

#ifdef WIN32 
#ifdef _DEBUG_MODE_
  AllocConsole();
  freopen("CONOUT$", "wb" , stdout);
#endif
#endif
	return app.exec();
}

