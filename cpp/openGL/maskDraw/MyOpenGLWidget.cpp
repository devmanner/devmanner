#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include "MyOpenGLWidget.h"

void paintQube();
void paintTetra();
void paintQube2f();
void paintTetra2f();

MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name) : QGLWidget(parent, name), m_xRot(0), m_yRot(0), m_zRot(0) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  m_scale = 1.0;
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
  glShadeModel(GL_FLAT);
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
  glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
  
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();
  glTranslatef( 0.0, 0.0, -3.0 );
  glScalef( m_scale, m_scale, m_scale );
  
  glRotatef( m_xRot, 1.0, 0.0, 0.0 );
  glRotatef( m_yRot, 0.0, 1.0, 0.0 ); 
  glRotatef( m_zRot, 0.0, 0.0, 1.0 );


  //FUNKAR OK!!!!!!!!!
    // Paint mask
    glColorMask(0, 0, 0, 0);
    glEnable(GL_STENCIL_TEST);
    glStencilFunc(GL_ALWAYS, 1, 1);
    glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
    //glDisable(GL_DEPTH_TEST);
    paintTetra();
  
    // Paint cube - mask
    // Rita överallt där maske inte är!
    glEnable(GL_DEPTH_TEST);
    glColorMask(1, 1, 1, 1);
    glStencilFunc(GL_NOTEQUAL, 1, 1);
    glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP);
    paintQube();
  
  
  //glClear(GL_STENCIL_BUFFER_BIT);
  
  /*
    glEnable(GL_STENCIL_TEST);
    glColorMask(0, 0, 0, 0);
    glStencilFunc(GL_ALWAYS, 1, 1);
    glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
    paintQube();

    // Rita överallt där masken är.
    glEnable(GL_DEPTH_TEST);
    glColorMask(1, 1, 1, 1);
    glStencilFunc(GL_NOTEQUAL, 1, 1);
    glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP);
    paintTetra();
    glDisable(GL_STENCIL_TEST);
  */
    //paintQube();
    //paintTetra();

  //  glFlush();
}

void paintQube() {
  glBegin(GL_QUADS);
  // Front face
  glColor3f(0.0, 1.0, 0.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  // Back face
  glColor3f(0.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(-1.0, -1.0, -1.0);

  // Top side face
  glColor3f(0.0, 0.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glVertex3f(-1.0, 1.0, -1.0);

  // Bottom side face
  glColor3f(1.0, 0.0, 0.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(-1.0, -1.0, -1.0);

  glColor3f(1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(-1.0, 1.0, -1.0);

  glColor3f(0.1, 0.1, 0.3);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glEnd();
}

void paintTetra() {
  GLfloat f = 0.001;
  glBegin(GL_TRIANGLES);
  glColor3f(0.0, 0.2, 1.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);

  glColor3f(0.0, 0.0, 1.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  glEnd();
  
  glBegin(GL_QUADS);
  glColor3f(1.0, 0.0, 0.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);

  glColor3f(0.0, 1.0, 1.0);
  glVertex3f(0.0+f, 0.0+f, 0.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  glVertex3f(1.0+f, 0.0+f, 0.0);

  glColor3f(0.0, 1.0, 0.0);
  glVertex3f(0.0+f, 1.0+f, -1.0);
  glVertex3f(1.0+f, 1.0+f, -1.0);
  glVertex3f(1.0+f, 1.0+f, 1.0);
  glVertex3f(0.0+f, 1.0+f, 1.0);

  glEnd();
}

void paintQube2f() {
  glBegin(GL_QUADS);
  // Front face
  glColor3f(0.0, 1.0, 0.0);
  glVertex2f(-1.0, 1.0);
  glVertex2f(1.0, 1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(-1.0, -1.0);
  // Back face
  glColor3f(0.0, 1.0, 1.0);
  glVertex2f(-1.0, 1.0);
  glVertex2f(1.0, 1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(-1.0, -1.0);
  // Top side face
  glColor3f(0.0, 0.0, 1.0);
  glVertex2f(-1.0, 1.0);
  glVertex2f(1.0, 1.0);
  glVertex2f(1.0, 1.0);
  glVertex2f(-1.0, 1.0);
  // Bottom side face
  glColor3f(1.0, 0.0, 0.0);
  glVertex2f(-1.0, -1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(-1.0, -1.0);

  glColor3f(1.0, 1.0, 1.0);
  glVertex2f(-1.0, 1.0);
  glVertex2f(-1.0, -1.0);
  glVertex2f(-1.0, -1.0);
  glVertex2f(-1.0, 1.0);

  glColor3f(0.1, 0.1, 0.3);
  glVertex2f(1.0, 1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(1.0, -1.0);
  glVertex2f(1.0, 1.0);
  glEnd();
}

void paintTetra2f() {
  glBegin(GL_TRIANGLES);
  glColor3f(1.0, 0.2, 0.0);
  glVertex2f(0.0, 0.0);
  glVertex2f(1.5, 1.5);
  glVertex2f(1.5, 1.5);

  glColor3f(0.0, 0.2, 1.0);
  glVertex2f(0.0, 0.0);
  glVertex2f(1.5, 1.5);
  glVertex2f(1.5, 0.0);

  glColor3f(0.0, 1.0, 0.2);
  glVertex2f(0.0, 0.0);
  glVertex2f(1.5, 1.5);
  glVertex2f(1.5, 0.0);

  glColor3f(1, 1, 1);
  glVertex2f(1.5, 0.0);
  glVertex2f(1.5, 1.5);
  glVertex2f(1.5, 1.5);
  glEnd();
}

