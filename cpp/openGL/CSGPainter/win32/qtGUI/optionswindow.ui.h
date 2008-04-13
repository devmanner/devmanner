/****************************************************************************
** ui.h extension file, included from the uic-generated form implementation.
**
** If you wish to add, delete or rename functions or slots use
** Qt Designer which will update this file, preserving your code. Create an
** init() function in place of a constructor, and a destroy() function in
** place of a destructor.
*****************************************************************************/

#include <stdio.h>
#include <string>
#include "../cuttercontroller.h"
#include "cncwindow.h"

using std::string;

void init() {
    printf("Init\n");
}

void optionsWindow::fileOpen(){
	string fileName;
	fileChooser->show();
	fileName = fileChooser->selectedFile().ascii();

#ifdef _DEBUG_MODE_
	printf("\nselected file: %s\n", fileName.c_str());
#endif
	try{
		// Give the file to the parser.
		m_parser.parseFile(fileName);
		m_codeWindow->readFile(fileName);
		// Enable some buttons.
		stepForwardButt->setEnabled(true);
		toEndButt->setEnabled(true);
		toStartButt->setEnabled(true);
	}
	catch(FileNotFoundException fnfe){
		QMessageBox error("File not found", fnfe.getMessage().c_str(), QMessageBox::Critical, 
			QMessageBox::Ok, QMessageBox::NoButton, QMessageBox::NoButton, this, "File not found", true );
		error.show();
#ifdef _DEBUG_MODE_
		printf("%s\n", fnfe.getMessage().c_str());
#endif
	}

}

void optionsWindow::fileExit(){
	close(false);
}


void optionsWindow::helpIndex(){

}


void optionsWindow::helpContents(){

}


void optionsWindow::helpAbout(){

}

void optionsWindow::stepForward(){
	if(m_parser.executeNext() == -1){ // Failure to execute command.
		QMessageBox error("End of file.", "End of file. Use \"To start\" to step back.", QMessageBox::Critical, 
			QMessageBox::Ok, QMessageBox::NoButton, QMessageBox::NoButton, this, "File not found", true );
		error.show();
	}
#ifdef _DEBUG_MODE_
  printf("Step forward\n");
#endif
	Vertex v = CutterController::getInstance().getMax() - CutterController::getInstance().getMin();
	if(v.m_x != UNDEFINED_VALUE)
		m_oglWindow->setZoom(-(v.m_x/10)/4,-(v.m_y/10)/4,-((v.m_x + v.m_y)/10)/3);

	m_codeWindow->notify();
}


void optionsWindow::stepBackward(){
    printf("Step backward\n");
		m_codeWindow->notify();
}


void optionsWindow::toStart() {
	stepForwardButt->setEnabled(true);
	toEndButt->setEnabled(true);
	m_parser.rewind();	
	CutterController::getInstance().reset();
	printf("To start\n");
	m_codeWindow->notify();
}


void optionsWindow::toEnd() {
	m_oglWindow->show();
	while(m_parser.executeNext() != -1)
		;
	stepForwardButt->setEnabled(false);
	toEndButt->setEnabled(false);
  printf("To end\n");
	m_codeWindow->notify();
}


void optionsWindow::toggleViewSource( int arg ) {
	if (arg == 2)
		m_codeWindow->show();
	else
		m_codeWindow->hide();
  printf("toggleViewSource: %d\n", arg);
}


void optionsWindow::toggleColorMode( int arg ){
    printf("toggleColorMode: %d\n", arg);
}
