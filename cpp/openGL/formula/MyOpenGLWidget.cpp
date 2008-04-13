#include <limits>
#include <math.h>
#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include "MyOpenGLWidget.h"


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
  case Key_N: m_scale -= 0.1; break;
  case Key_M: m_scale += 0.1; break;

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
  
  m_list = glGenLists(1);
  glNewList(m_list, GL_COMPILE);
  glBegin(GL_QUAD_STRIP);
  glColor3f(1, 0, 0);
  int i = 0;
  for (double v = 0; v < 2 * M_PI; v += 0.1) { // Small circle
    for (double u = 0; u < 2 * M_PI; u += 0.1, i = (i + 1) % 4) {
      double r1 = 4 * (1 - cos(u)/2);
      double r2 = 4 * (1 - cos(u-.1)/2);
      double x1, y1, x2, y2, z1, z2;
      if (u < M_PI) {
	x1 = 6*cos(u)*(1+sin(u)) + r1*cos(u)*cos(v);
	y1 = 16*sin(u) + r1*sin(u)*cos(v);
	x2 = 6*cos(u-.1)*(1+sin(u-.1)) + r2*cos(u-.1)*cos(v-.1);
	y2 = 16*sin(u-.1) + r2*sin(u-.1)*cos(v-.1);
      } else {
	x1 = (6*cos(u)) * (1 + sin(u))+ r1*cos(v+M_PI);
	y1 = 16*sin(u);
	x2 = (6*cos(u-.1)) * (1 + sin(u-.1))+ r2*cos(v-.1+M_PI);
	y2 = 16*sin(u-.1);
      }
      z1 = r1*sin(v);
      z2 = r2*sin(v-.1);
      switch (i){
      case 0: glColor3f(1, 0, 0); break;
      case 1: glColor3f(1, 1, 0); break;
      case 2: glColor3f(0, 1, 0); break;
      case 3: glColor3f(0, 1, 1); break;
      case 4: glColor3f(0, 0, 1); break;
      case 5: glColor3f(1, 1, 1); break;
      }
	
      //glColor3f(v/M_PI, u/M_PI, 1);
      glVertex3f(x1, y1, z1);
      glVertex3f(x2, y2, z2);
    }
  }
  glEnd();
  glEndList();
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

  glCallList(m_list);
  
}

