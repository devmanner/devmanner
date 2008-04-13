#include <qdatetime.h>
#include <qtimer.h>
#include <assert.h>
#include <qnamespace.h>
#include <qapplication.h>
#include "MyOpenGLWidget.h"
#include "../shape.h"
#include "../cuttercontroller.h"

MyOpenGLWidget::MyOpenGLWidget( int timerDelay, QWidget *parent, const char *name )
: QGLWidget(QGLFormat(StencilBuffer), parent,name), m_csg(false), m_color(false),
  m_xrot(0.0), m_yrot(0.0), m_zrot(0.0){
	setFocusPolicy( QWidget::StrongFocus );
	timer = new QTimer( this, 0 );
	QObject::connect( timer, SIGNAL(timeout()), this, SLOT(updateGL()) );
	timer->start( timerDelay );
}

/*************************
* Keyboard input handler *
*************************/
void MyOpenGLWidget::keyPressEvent ( QKeyEvent * e )
{
	QGLWidget::keyPressEvent( e );
	switch(e->key()){
		case Key_Escape:	qApp->quit();
		case Key_C:				m_csg = !m_csg;break;
		case Key_T:				CSGPainter::getInstance().toggleSurfaces();break;
		case Key_Left:		m_yrot -= 3.0f;break;
		case Key_Right:		m_yrot += 3.0f;break;
		case Key_Up:			m_xrot += 3.0f;break;
		case Key_Down:		m_xrot -= 3.0f;break;
		case Key_Z:				m_zrot -= 3.0f;break;
		case Key_A:				m_zrot += 3.0f;break;

		case Key_I:				m_zoomy -= 0.1f;break;
		case Key_M:				m_zoomy += 0.1f;break;
		case Key_J:				m_zoomx += 0.1f;break;
		case Key_L:				m_zoomx -= 0.1f;break;
		case Key_K:				m_zoomz -= 0.1f;break;
		case Key_O:				m_zoomz += 0.1f;break;


		case Key_F:				m_color = !m_color;
											if(m_color)
												glEnable(GL_COLOR_MATERIAL);
											else
												glDisable(GL_COLOR_MATERIAL);
											break;
											
		default : break;
	}
}

/**********************
* Mouse input handler *
**********************/
void MyOpenGLWidget::mousePressEvent ( QMouseEvent * e ){
	QGLWidget::mousePressEvent ( e );
}

/********************
* Initialize OpenGL *
********************/
void MyOpenGLWidget::initializeGL(void){
	float light_pos[] = {0,5,5,1};
	float light_amb[] = {0.2f, 0.2f, 0.2f ,1.0f};

	glMatrixMode(GL_PROJECTION);
  glFrustum(-.33, .33, -.33, .33, .5, 20);

  glMatrixMode(GL_MODELVIEW);

	glEnable(GL_BLEND);
	glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
	glLightfv(GL_LIGHT0,GL_POSITION, light_pos);
	glLightfv(GL_LIGHT0,GL_AMBIENT,light_amb);

	glEnable(GL_COLOR_MATERIAL);

  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable(GL_NORMALIZE);
  glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, GL_TRUE);
	printf("initGL()\n");
}

/*************************
* Resize OpenGL viewport *
*************************/
void MyOpenGLWidget::resizeGL( int width, int height ){
	height = (!height)?1:height;
	
	glViewport(0, 0, width, height);
	
	glMatrixMode(GL_PROJECTION);// Select The Projection Matrix
	glLoadIdentity();// Reset The Projection Matrix 
	
	gluPerspective(45.0f,(GLfloat)width/(GLfloat)height,0.1f,100.0f); // Calculate The Aspect Ratio Of The Window
	glMatrixMode(GL_MODELVIEW);// Select The Modelview Matrix
	glLoadIdentity();
}

/***********************
* Repaint OpenGL scene *
***********************/
void MyOpenGLWidget::paintGL(void){
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);// Clear The Screen And The Depth Buffer
	glLoadIdentity();// Reset The View
	
	glTranslatef(m_zoomx, m_zoomy, m_zoomz);
	glRotatef(m_xrot, 1.,0., 0.);
	glRotatef(m_yrot, 0.,1., 0.);
	glRotatef(m_zrot, 0.,0., 1.);

	if(m_csg)
		CSGPainter::getInstance().redrawCSG();
	else
		CSGPainter::getInstance().redrawNoCSG();

	glPushMatrix();
		glBegin(GL_LINES);
			glColor3f(1.,0.,0.);
			glVertex3f(-10, 0, 0);
			glVertex3f(10, 0, 0);
			glColor3f(0.,1.,0.);
			glVertex3f(0, -10, 0);
			glVertex3f(0, 10, 0);
			glColor3f(0.,0.,1.);
			glVertex3f(0, 0, -10);
			glVertex3f(0, 0, 10);
		glEnd();
	glPopMatrix();
}

