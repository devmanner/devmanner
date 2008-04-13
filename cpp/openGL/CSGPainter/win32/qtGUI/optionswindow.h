/****************************************************************************
** Form interface generated from reading ui file 'optionswindow.ui'
**
** Created: Fri May 9 13:49:46 2003
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.1.2   edited Dec 19 11:45 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef OPTIONSWINDOW_H
#define OPTIONSWINDOW_H

#include <qvariant.h>
#include <qmainwindow.h>
#include <qdialog.h>
#include <qmessagebox.h>

#include "myopenglwidget.h"
#include "../cncparser.h"

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QAction;
class QActionGroup;
class QToolBar;
class QPopupMenu;
class QGroupBox;
class QCheckBox;
class QPushButton;
class QFileDialog;
class CNCWindow;

class optionsWindow : public QMainWindow{
    Q_OBJECT

public:
    optionsWindow( QWidget* parent = 0, const char* name = 0, WFlags fl = WType_TopLevel );
    ~optionsWindow();

    QGroupBox* groupBox2;
    QCheckBox* bluryColorsCheck;
    QCheckBox* viewSourceCheck;
		QCheckBox* transparencySourceCheck;
		QCheckBox* csgSourceCheck;
    QGroupBox* simulationGroup;
    QPushButton* stepForwardButt;
    QPushButton* toStartButt;
    QPushButton* stepBackwardButt;
    QPushButton* toEndButt;
    QMenuBar *menubar;
    QPopupMenu *fileMenu;
    QPopupMenu *helpMenu;
    QAction* fileOpenAction;
    QAction* fileSaveAction;
    QAction* fileSaveAsAction;
    QAction* filePrintAction;
    QAction* fileExitAction;
    QAction* helpContentsAction;
    QAction* helpIndexAction;
    QAction* helpAboutAction;
    QAction* Action;
		QFileDialog* fileChooser;

private:
		CNCParser			 m_parser;
		MyOpenGLWidget *m_oglWindow;
		CNCWindow			*m_codeWindow;

public slots:
    virtual void fileOpen();
    virtual void fileExit();
    virtual void helpIndex();
    virtual void helpContents();
    virtual void helpAbout();
    virtual void stepForward();
    virtual void stepBackward();
    virtual void toStart();
    virtual void toEnd();
    virtual void toggleViewSource( int arg );
    virtual void toggleColorMode( int arg );

protected:

protected slots:
    virtual void languageChange();
};

#endif // OPTIONSWINDOW_H
