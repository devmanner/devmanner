#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include "MyOpenGLWidget.h"

void MyOpenGLWidget::drawVox() {
  for (GLfloat x = 0; x < 1; x += 0.05) {
    for (GLfloat y = 0; y < 1; y += 0.05) {
      for (GLfloat z = 0; z < 1; z += 0.05) {
	glBegin(GL_QUADS);
	glColor3f(x, 0, 0);
      	glVertex3f(x - m_voxSize/2, y - m_voxSize/2, z);
	glVertex3f(x - m_voxSize/2, y + m_voxSize/2, z);
	glVertex3f(x + m_voxSize/2, y + m_voxSize/2, z);
	glVertex3f(x + m_voxSize/2, y - m_voxSize/2, z);
	glEnd();
      }
    }
  }
}


MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name) : QGLWidget(parent, name), m_xRot(0), m_yRot(0), m_zRot(0), m_voxSize(0) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  m_scale = 1.0;

  GLfloat f=0;
  glGetFloatv(GL_POINT_SIZE_GRANULARITY, &f);
  printf("GL_POINT_SIZE_GRANULARITY = %f\n", f);
  glGetFloatv(GL_POINT_SIZE_RANGE, &f);
  printf("GL_POINT_SIZE_RANGE = %f\n", f);
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
  case Key_C: m_voxSize += 0.1; printf("voxSize: %.2f\n", m_voxSize); break;
  case Key_V: m_voxSize -= 0.1; printf("voxSize: %.2f\n", m_voxSize); break;
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
    glOrtho(-1.5, 1.5, -1.5 * (GLfloat) height / (GLfloat) width, 1.5 * (GLfloat) height / (GLfloat) width, -10.0, 10.0);
  else
    glOrtho(-1.5 * (GLfloat) width / (GLfloat) height, 1.5 * (GLfloat) width / (GLfloat) height, -1.5, 1.5, -10.0, 10.0);

  // Select The Modelview Matrix
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
}

/***********************
* Repaint OpenGL scene *
***********************/
void MyOpenGLWidget::paintGL(void) {
  glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();
  glTranslatef( 0.0, 0.0, -3.0 );
  glScalef( m_scale, m_scale, m_scale );
  
  glRotatef( m_xRot, 1.0, 0.0, 0.0 );
  glRotatef( m_yRot, 0.0, 1.0, 0.0 ); 
  glRotatef( m_zRot, 0.0, 0.0, 1.0 );

  drawVox();

  glFlush();
}


