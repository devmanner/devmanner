#include <qapplication.h>
#if defined(WIN32) && defined(_DEBUG_MODE_)
#include <windows.h>
#endif
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

