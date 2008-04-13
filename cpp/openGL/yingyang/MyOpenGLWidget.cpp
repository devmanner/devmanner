#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include <vector>
#include <math.h>
#include "MyOpenGLWidget.h"

MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name) : QGLWidget(parent, name), m_xRot(0), m_yRot(0), m_zRot(0), m_redRot(90), m_blueRot(270) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  m_scale = 1.0;
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
  //glTranslatef( 0.0, 0.0, -3.0 );
  glScalef( m_scale, m_scale, m_scale );

  glRotatef( m_xRot, 1.0, 0.0, 0.0 );
  glRotatef( m_yRot, 0.0, 1.0, 0.0 ); 
  glRotatef( m_zRot, 0.0, 0.0, 1.0 );

  m_redRot = (int)(m_redRot + 1.0) % 360;
  m_blueRot = (int)(m_blueRot + 1.0) % 360;
  // Rita den röda delen.
  
  glPushMatrix();
    glRotatef(180, 0.0, 1.0, 0.0);
    glRotatef(++m_redRot, 0.0, 0.0, 1.0);
    glColor3f(1, 0, 0);
    glCallList(m_list);
  glPopMatrix();
  
  glPushMatrix();
    glRotatef(++m_blueRot, 0.0, 1.0, 0.0);
    glRotatef(90, 1.0, 0.0, 0.0);
    glColor3f(0, 0, 1);
    glCallList(m_list);
  glPopMatrix();

  glFlush();
}

struct Vertex{ 
  double m_x, m_y, m_z;
  Vertex(double x, double y, double z) : m_x(x), m_y(y), m_z(z) { }
  void print(){
    printf("[%.2f, %.2f, %.2f]\n", m_x, m_y, m_z);
  }
  void draw(){
    glVertex3f(m_x, m_y, m_z);
  }
  Vertex operator-(const Vertex &v){
    return Vertex(m_x - v.m_x, m_y - v.m_y, m_z - v.m_z);
  }
  Vertex operator+(const Vertex &v){
    return Vertex(m_x + v.m_x, m_y + v.m_y, m_z + v.m_z);
  }
  Vertex operator*(double d){
    return Vertex(m_x*d, m_y*d, m_z*d);
  }
  double operator*(const Vertex& v){
    return m_x*v.m_x+m_y*v.m_x+m_z*v.m_x;
  }
};


void drawBerzier(Vertex start1, Vertex dir1, Vertex start2, Vertex dir2) {

  Vertex c = (dir1-start1)*3.0;
  Vertex b = (dir2 - dir1)*3.0 - c;
  Vertex a = start2 - start1 - c - b;

  for (double t = 0; t <= 1.0; t += 0.01) {
    Vertex pt = a*t*t*t + b*t*t + c*t + start1;
    pt.draw();
  }
}

void circle(Vertex center, double radius) {
  for (double angle=0; angle < 2*M_PI; angle += 2*M_PI/100)
    glVertex3f(center.m_x+radius*cos(angle), center.m_y+radius*sin(angle), center.m_z);
}

GLuint MyOpenGLWidget::makeList() {
  GLuint l = glGenLists(1);
  glNewList(l, GL_COMPILE);
    glPushMatrix();
    glBegin(GL_LINE_STRIP);
      // "S":et
      drawBerzier(Vertex(0, 1, 0), Vertex(0.75, 1, 0), Vertex(0, 0, 0), Vertex(0.75, 0, 0));
      drawBerzier(Vertex(0, 0, 0), Vertex(-0.75, 0, 0), Vertex(0, -1, 0), Vertex(-0.75, -1, 0));
    glEnd();
    glBegin(GL_LINE_STRIP);
      // Halvcirkeln
      drawBerzier(Vertex(0, 1, 0), Vertex(-1.5, 1, 0), Vertex(0, -1, 0), Vertex(-1.5, -1, 0));
    glEnd();
    // Lilla cirkeln "utanför"
    glBegin(GL_LINE_STRIP);
	circle(Vertex(0, -0.5, 0), 0.2);
    glEnd();
    // Lilla cirkeln "innanför"
    glBegin(GL_LINE_STRIP);
      circle(Vertex(0, 0.5, 0), 0.2);
    glEnd();
    glPopMatrix();
  glEndList();
  return l;
}

