/****************************************************************************
** ui.h extension file, included from the uic-generated form implementation.
**
** If you wish to add, delete or rename functions or slots use
** Qt Designer which will update this file, preserving your code. Create an
** init() function in place of a constructor, and a destroy() function in
** place of a destructor.
*****************************************************************************/

#include <string> 
#include <qfiledialog.h>
#include <stdio.h> 

#include "../cuttercontroller.h" 
#include "cncwindow.h" 

 
using std::string; 

void init() {
  printf("FUCK!!!\n");
    
  optionsWindow::transparencySourceCheck = new QCheckBox( groupBox2, "transparencySourceCheck");
  optionsWindow::transparencySourceCheck->setGeometry( QRect( 110, 40, 100, 20 ) );
  optionsWindow::transparencySourceCheck->setChecked( TRUE );
  optionsWindow::transparencySourceCheck->setText("Transparency");
  
  optionsWindow::csgSourceCheck = new QCheckBox( groupBox2, "csgSourceCheck");
  optionsWindow::csgSourceCheck->setGeometry( QRect( 110, 20, 100, 20 ) );
  optionsWindow::csgSourceCheck->setChecked( FALSE );
  optionsWindow::csgSourceCheck->setText("Turn on csg");
  
  optionsWindow::m_oglWindow = new MyOpenGLWidget(10);
  optionsWindow::m_oglWindow->setCaption("[Qt] Graphical simulation window");
  optionsWindow::m_oglWindow->setGeometry(300, 25, 700, 400);
  optionsWindow::m_oglWindow->show();
  
  optionsWindow::m_codeWindow = new CNCWindow("", &m_parser);
  optionsWindow::m_codeWindow->setGeometry(10, 250, 280, 500);
  optionsWindow::m_codeWindow->setCaption("[Qt] CNC code window");
  optionsWindow::m_codeWindow->show();
  
  optionsWindow::setGeometry(10, 25, 280, 180);
  optionsWindow::setCaption("[Qt] Cutter simulator v0.1");
  
  printf("Init\n");
}

void destroy() {
  delete optionsWindow::transparencySourceCheck;
  delete optionsWindow::csgSourceCheck;
  delete optionsWindow::m_oglWindow;
  delete optionsWindow::m_codeWindow;
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
