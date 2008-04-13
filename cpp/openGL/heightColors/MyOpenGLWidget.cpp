#include <limits>
#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include "MyOpenGLWidget.h"
#include "colorsetter.h"

MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name) : QGLWidget(parent, name), m_xRot(0), m_yRot(0), m_zRot(0) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  m_scale = 0.5;
  /*
  * Create displaylists after initializeGL()!!!
  */
}

/*************************
* Keyboard input handler *
*************************/
void MyOpenGLWidget::keyPressEvent (QKeyEvent *e) {
  GLfloat app = 5.0; // angle per press
  QGLWidget::keyPressEvent(e);
  switch(e->key()) {
  case Key_Escape: qApp->quit(); break;
  case Key_Left: m_yRot -= app; break;
  case Key_Right: m_yRot += app; break;
  case Key_Up: m_xRot += app; break;
  case Key_Down: m_xRot -= app; break;
  case Key_X: m_zRot -= app; break;
  case Key_Z: m_zRot += app; break;
  case Key_T: ColorSetter::getInstance().toggleColorMode(); break;
  }
}

/**********************
* Mouse input handler *
**********************/
void MyOpenGLWidget::mousePressEvent ( QMouseEvent * e ) {
  QGLWidget::mousePressEvent ( e );
}

/********************
* Initialize OpenGL *
********************/
void MyOpenGLWidget::initializeGL(void) {
  glShadeModel(GL_SMOOTH);
  glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
  glClearDepth(1.0f);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LEQUAL);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
}

/*************************
* Resize OpenGL viewport *
*************************/
void MyOpenGLWidget::resizeGL( int width, int height ) {
  glViewport(0, 0, width, height);
  // Select The Projection Matrix
  glMatrixMode(GL_PROJECTION);
  // Reset The Projection Matrix 
  glLoadIdentity();
  if (width <= height)
    glOrtho(-1.5, 1.5, -1.5 * (GLfloat) height / (GLfloat) width,
	    1.5 * (GLfloat) height / (GLfloat) width, -10.0, 10.0);
  else
    glOrtho(-1.5 * (GLfloat) width / (GLfloat) height, 1.5 * (GLfloat) width / (GLfloat) height, 
	    -1.5, 1.5, -10.0, 10.0);

  // Select The Modelview Matrix
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
}


/***********************
* Repaint OpenGL scene *
***********************/
void MyOpenGLWidget::paintGL(void) {

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT /*| GL_STENCIL_BUFFER_BIT*/);
  
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef( 0.0, 0.0, -3.0 );
  glScalef( m_scale, m_scale, m_scale );
  
  glRotatef( m_xRot, 1.0, 0.0, 0.0 );
  glRotatef( m_yRot, 0.0, 1.0, 0.0 ); 
  glRotatef( m_zRot, 0.0, 0.0, 1.0 );

  glBegin(GL_LINES);
    glColor3f(0, 0, 1);

    glVertex3f(-4, 0, 3);
    glVertex3f(4, 0, 3);
    glVertex3f(-4, 0, 2);
    glVertex3f(4, 0, 2);
    glVertex3f(-4, 0, 1);
    glVertex3f(4, 0, 1);
    glVertex3f(-4, 0, 0);
    glVertex3f(4, 0, 0);
    glVertex3f(-4, 0, -1);
    glVertex3f(4, 0, -1);
    glVertex3f(-4, 0, -2);
    glVertex3f(4, 0, -2);
    glVertex3f(-4, 0, -3);
    glVertex3f(4, 0, -3);
  glEnd();
  
  /*
  glBegin(GL_QUAD_STRIP);
  for (double d = 3; d > -3; d -= 0.05) {
    Vertex v1(3, 0, d);
    Vertex v2 (-3, 0, d);
    ColorSetter::getInstance().setColor(v1);
    v1.draw();
    ColorSetter::getInstance().setColor(v2);
    v2.draw();
    }
  glEnd();
  */

  GLfloat f = 0.001;
  glBegin(GL_TRIANGLES);
  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);
  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);

  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  glEnd();
  
  glBegin(GL_QUADS);
  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);
  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);

  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  ColorSetter::getInstance().setColor(0.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);

  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);
  ColorSetter::getInstance().setColor(-1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  ColorSetter::getInstance().setColor(1.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);

  glEnd();

  glFlush();
  GLError::get_instance().print();
}

