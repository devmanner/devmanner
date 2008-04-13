#include <qpushbutton.h>
#include <qslider.h>
#include <qlayout.h>
#include <qframe.h>
#include <qmenubar.h>
#include <qpopupmenu.h>
#include <qapplication.h>
#include <qkeycode.h>
#include "globjwin.h"
#include "glbox.h"


GLObjectWindow::GLObjectWindow( QWidget* parent, const char* name )
    : QWidget( parent, name ) {
  // Create nice frames to put around the OpenGL widgets
  QFrame* f1 = new QFrame( this, "frame1" );
  f1->setFrameStyle( QFrame::Sunken | QFrame::Panel );
  f1->setLineWidth( 2 );
  
  // Create an OpenGL widget
  m_glb = new GLBox( f1, "glbox1", 550, 350);
}
