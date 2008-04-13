#include "MyOpenGLWidget.h"

MyOpenGLWidget::MyOpenGLWidget(int timerDelay, QWidget *parent, const char *name)
  : QGLWidget(parent, name), m_formula(NULL),
    m_xRotMod(((rand() % 1000) - 500) / 100.0),
    m_yRotMod(((rand() % 1000) - 500) / 100.0),
    m_zRotMod(((rand() % 1000) - 500) / 100.0),
    m_xRot(0.0), m_yRot(0.0), m_zRot(0.0) {
  setFocusPolicy(QWidget::StrongFocus);
  timer = new QTimer(this, 0);
  QObject::connect(timer, SIGNAL(timeout()), this, SLOT(updateGL()));
  timer->start(timerDelay);
  /*
  * Create displaylists after initializeGL()!!!
  */
  srand(time(NULL));
}

/*************************
* Keyboard input handler *
*************************/
void MyOpenGLWidget::keyPressEvent (QKeyEvent *e) {
  QGLWidget::keyPressEvent(e);
  switch(e->key()) {
  case Key_Escape: qApp->quit(); break;
  default: break;
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

  //  m_formula = new KleinBottle();
  m_formula = new SphericalHarmonics();
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

  updateRotation();
  glRotatef( m_xRot, 1.0, 0.0, 0.0 );
  glRotatef( m_yRot, 0.0, 1.0, 0.0 ); 
  glRotatef( m_zRot, 0.0, 0.0, 1.0 );

  m_formula->draw();
}

// Update rotation vareables.
void MyOpenGLWidget::updateRotation() {
  static int paints = 0;
  ++paints;
  if (paints > 10) {
    // Update the rotation modifier every 10:th time.
    m_xRotMod += ((rand() % 100) - 50) / 10.0;
    m_yRotMod += ((rand() % 100) - 50) / 10.0;
    m_zRotMod += ((rand() % 100) - 50) / 10.0;
    paints = 0;
    //printf("m_xRotMod: %.2f\nm_yRotMod: %.2f\nm_zRotMod: %.2f\n", m_xRotMod, m_yRotMod, m_zRotMod);
  }
  m_xRot += m_xRotMod;
  m_yRot += m_yRotMod;
  m_zRot += m_zRotMod;
  // Some security... this is a sirious project...
  if (m_xRot > 360) m_xRot -= 360;
  if (m_xRot < -360) m_xRot += 360;
  if (m_yRot > 360) m_yRot -= 360;
  if (m_yRot < -360) m_yRot += 360;
  if (m_zRot > 360) m_zRot -= 360;
  if (m_zRot < -360) m_zRot += 360;
  //printf("m_xRot: %.2f\nm_yRot: %.2f\nm_zRot: %.2f\n", m_xRot, m_yRot, m_zRot);
}
