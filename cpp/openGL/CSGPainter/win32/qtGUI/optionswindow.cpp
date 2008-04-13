/****************************************************************************
** Form implementation generated from reading ui file 'optionswindow.ui'
**
** Created: Fri May 9 13:49:52 2003
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.1.2   edited Dec 19 11:45 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "optionswindow.h"
#include "myopenglwidget.h"

#define INCLUDE_MENUITEM_DEF

#include <qvariant.h>
#include <qgroupbox.h>
#include <qcheckbox.h>
#include <qpushbutton.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include <qaction.h>
#include <qmenubar.h>
#include <qpopupmenu.h>
#include <qtoolbar.h>
#include <qimage.h>
#include <qpixmap.h>
#include <qfiledialog.h>


#include "optionswindow.ui.h"

#include "cncwindow.h"


/* 
 *  Constructs a optionsWindow as a child of 'parent', with the 
 *  name 'name' and widget flags set to 'f'.
 *
 */
optionsWindow::optionsWindow( QWidget* parent, const char* name, WFlags fl )
    : QMainWindow( parent, name, fl ), m_parser()
{
    (void)statusBar();
    if ( !name )
			setName( "xjobb2003" );
    setCentralWidget( new QWidget( this, "qt_central_widget" ) );

    groupBox2 = new QGroupBox( centralWidget(), "groupBox2" );
    groupBox2->setGeometry( QRect( 10, 50, 260, 70 ) );

    bluryColorsCheck = new QCheckBox( groupBox2, "bluryColorsCheck" );
    bluryColorsCheck->setEnabled( TRUE );
    bluryColorsCheck->setGeometry( QRect( 10, 40, 100, 20 ) );
    bluryColorsCheck->setChecked( TRUE );

    viewSourceCheck = new QCheckBox( groupBox2, "viewSourceCheck" );
    viewSourceCheck->setGeometry( QRect( 10, 20, 100, 20 ) );
    viewSourceCheck->setChecked( TRUE );
      
    transparencySourceCheck = new QCheckBox( groupBox2, "transparencySourceCheck");
    transparencySourceCheck->setGeometry( QRect( 110, 40, 100, 20 ) );
    transparencySourceCheck->setChecked( TRUE );
    transparencySourceCheck->setText("Transparency");
    
    csgSourceCheck = new QCheckBox( groupBox2, "csgSourceCheck");
    csgSourceCheck->setGeometry( QRect( 110, 20, 100, 20 ) );
    csgSourceCheck->setChecked( FALSE );
    csgSourceCheck->setText("Turn on csg");

    simulationGroup = new QGroupBox( centralWidget(), "simulationGroup" );
    simulationGroup->setGeometry( QRect( 10, 0, 260, 50 ) );

    stepForwardButt = new QPushButton( simulationGroup, "stepForwardButt" );
    stepForwardButt->setGeometry( QRect( 130, 20, 60, 20 ) );
		stepForwardButt->setEnabled(false);

    toStartButt = new QPushButton( simulationGroup, "toStartButt" );
    toStartButt->setGeometry( QRect( 10, 20, 60, 20 ) );
		toStartButt->setEnabled(false);

    stepBackwardButt = new QPushButton( simulationGroup, "stepBackwardButt" );
    stepBackwardButt->setGeometry( QRect( 70, 20, 60, 20 ) );
		stepBackwardButt->setEnabled(false);

    toEndButt = new QPushButton( simulationGroup, "toEndButt" );
    toEndButt->setGeometry( QRect( 190, 20, 60, 20 ) );
		toEndButt->setEnabled(false);

		fileChooser = new QFileDialog( "", 0, this, "Select CNC-file", true);
	
    // actions
    fileOpenAction = new QAction( this, "fileOpenAction" );
    fileOpenAction->setToggleAction( FALSE );
    fileOpenAction->setOn( FALSE );
    fileOpenAction->setEnabled( TRUE );
		//fileOpenAction->setIconSet( QIconSet( QPixmap::fromMimeSource( "fileopen" ) ) );
    fileSaveAction = new QAction( this, "fileSaveAction" );
		//fileSaveAction->setIconSet( QIconSet( QPixmap::fromMimeSource( "filesave" ) ) );
    fileSaveAsAction = new QAction( this, "fileSaveAsAction" );
    filePrintAction = new QAction( this, "filePrintAction" );
    //filePrintAction->setIconSet( QIconSet( QPixmap::fromMimeSource( "print" ) ) );
    fileExitAction = new QAction( this, "fileExitAction" );
    helpContentsAction = new QAction( this, "helpContentsAction" );
    helpIndexAction = new QAction( this, "helpIndexAction" );
    helpAboutAction = new QAction( this, "helpAboutAction" );
    Action = new QAction( this, "Action" );


    // toolbars


    // menubar
    menubar = new QMenuBar( this, "menubar" );

    fileMenu = new QPopupMenu( this );

    fileOpenAction->addTo( fileMenu );
    fileMenu->insertSeparator();
    fileMenu->insertSeparator();
    fileExitAction->addTo( fileMenu );
    menubar->insertItem( QString(""), fileMenu, 0 );
    helpMenu = new QPopupMenu( this );

    helpContentsAction->addTo( helpMenu );
    helpIndexAction->addTo( helpMenu );
    helpMenu->insertSeparator();
    helpAboutAction->addTo( helpMenu );
    menubar->insertItem( QString(""), helpMenu, 1 );

    languageChange();
    resize( QSize(280, 174).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
    connect( fileOpenAction, SIGNAL( activated() ), this, SLOT( fileOpen() ) );
    connect( fileExitAction, SIGNAL( activated() ), this, SLOT( fileExit() ) );
    connect( helpIndexAction, SIGNAL( activated() ), this, SLOT( helpIndex() ) );
    connect( helpContentsAction, SIGNAL( activated() ), this, SLOT( helpContents() ) );
    connect( helpAboutAction, SIGNAL( activated() ), this, SLOT( helpAbout() ) );
    connect( stepForwardButt, SIGNAL( clicked() ), this, SLOT( stepForward() ) );
    connect( stepBackwardButt, SIGNAL( clicked() ), this, SLOT( stepBackward() ) );
    connect( toStartButt, SIGNAL( clicked() ), this, SLOT( toStart() ) );
    connect( toEndButt, SIGNAL( clicked() ), this, SLOT( toEnd() ) );
    connect( viewSourceCheck, SIGNAL( stateChanged(int) ), this, SLOT( toggleViewSource(int) ) );
    connect( bluryColorsCheck, SIGNAL( stateChanged(int) ), this, SLOT( toggleColorMode(int) ) );

    // tab order
    setTabOrder( toStartButt, stepBackwardButt );
    setTabOrder( stepBackwardButt, stepForwardButt );
    setTabOrder( stepForwardButt, toEndButt );
    setTabOrder( toEndButt, viewSourceCheck );
    setTabOrder( viewSourceCheck, bluryColorsCheck );

		//m_oglWindow.setCentralWidget(new MyOpenGLWidget());
		m_oglWindow = new MyOpenGLWidget(10);
		m_oglWindow->setCaption("[Qt] Graphical simulation window");
		m_oglWindow->setGeometry(300, 25, 700, 400);
		m_oglWindow->show();

		m_codeWindow = new CNCWindow("", &m_parser);
		m_codeWindow->setGeometry(10, 250, 280, 500);
		m_codeWindow->setCaption("[Qt] CNC code window");
		m_codeWindow->show();

		setGeometry(10, 25, 280, 180);
		setCaption("[Qt] Cutter simulator v0.1");
}

/*
 *  Destroys the object and frees any allocated resources
 */
optionsWindow::~optionsWindow()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void optionsWindow::languageChange()
{
    setCaption( tr( "Options" ) );
    groupBox2->setTitle( tr( "Visualization options" ) );
    bluryColorsCheck->setText( tr( "Blury colors" ) );
    viewSourceCheck->setText( tr( "View source" ) );
    simulationGroup->setTitle( tr( "Simuation" ) );
    stepForwardButt->setText( tr( "Step >" ) );
    toStartButt->setText( tr( "To start" ) );
    stepBackwardButt->setText( tr( "< Step" ) );
    toEndButt->setText( tr( "To end" ) );
    fileOpenAction->setText( tr( "Open" ) );
    fileOpenAction->setMenuText( tr( "&Open..." ) );
    fileSaveAction->setText( tr( "Save" ) );
    fileSaveAction->setMenuText( tr( "&Save" ) );
    fileSaveAsAction->setText( tr( "Save As" ) );
    fileSaveAsAction->setMenuText( tr( "Save &As..." ) );
    filePrintAction->setText( tr( "Print" ) );
    filePrintAction->setMenuText( tr( "&Print..." ) );
    fileExitAction->setText( tr( "Exit" ) );
    fileExitAction->setMenuText( tr( "E&xit" ) );
    helpContentsAction->setText( tr( "Contents" ) );
    helpContentsAction->setMenuText( tr( "&Contents..." ) );
    helpIndexAction->setText( tr( "Index" ) );
    helpIndexAction->setMenuText( tr( "&Index..." ) );
    helpAboutAction->setText( tr( "About" ) );
    helpAboutAction->setMenuText( tr( "&About" ) );
    Action->setText( tr( "Action" ) );
    menubar->findItem( 0 )->setText( tr( "&File" ) );
    menubar->findItem( 1 )->setText( tr( "&Help" ) );
}

