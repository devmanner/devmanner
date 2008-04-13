#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include <vector>
#include <math.h>
#include "MyOpenGLWidget.h"

MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name) : QGLWidget(parent, name), m_xRot(0), m_yRot(0), m_zRot(0) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  m_scale = 1.0;
  /*
  * Create displaylists after initializeGL()!!!
  */
  srand(time(NULL));
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
  glShadeModel(GL_SMOOTH);
  glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
  glClearDepth(1.0f);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LEQUAL);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  // Skapa listan.
  m_list = makeList();
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

  // Ropa på den fina listan.
  glCallList(m_list);

  glFlush();
  GLError::get_instance().print();
}

void MyOpenGLWidget::setColor(GLfloat y) {
  GLfloat maxy = 2.0;
  if (y < 0) {
    glColor3f(0, 0, 0);
    return;
  }
  glColor3f(1-(y/maxy), 0, y/maxy);
}

struct Point2D {
  GLfloat x, y;
  Point2D(double _x, double _y) : x(_x), y(_y) { }
};

// Här skapas en displaylist med alla punkter.
GLuint MyOpenGLWidget::makeList() {
  std::vector<Point2D> plist; // punkter i ett tillplattat 2d-plan.

  // Fyll med lite värden... Dessa punkter kan man låta vektyget skapa och ändra i.
  plist.push_back(Point2D(0, 0.5));
  for (int i = 1; i < 100; ++i)
    plist.push_back(Point2D(i / 50.0, plist[i-1].y + ((rand() % 100) / 1000.0)-0.05));
  plist.push_back(Point2D(0, 0.5));

  // Rita alltihopa.
  GLuint l = glGenLists(1);
  glNewList(l, GL_COMPILE);
    glPushMatrix();
      glBegin(GL_QUAD_STRIP);
      glColor3f(0,0,1);
      for(unsigned int i = 0; i < plist.size()-1; ++i){
	for (double angle = 0; angle < (2*M_PI); angle += 0.5) {
	  // Sätt en fin färg.
	  glColor3f(angle/(2*M_PI), 1-(angle/(2*M_PI)), 0.1); 
	  /* Lite magi:
	   * x: ges av 2D-punktens x koordinat.
	   * y: räknas ut med enhetscirkelformeln, tänk att planet är (y, z) planet.
	   * z: samma som y.
	   */
	  glVertex3f(plist[i].x, cos(angle)*plist[i].y, sin(angle)*plist[i].y);
	  glVertex3f(plist[i+1].x, cos(angle)*plist[i+1].y, sin(angle)*plist[i+1].y);
	}
      }
      glEnd();
    glPopMatrix();
  glEndList();
  return l;
}
