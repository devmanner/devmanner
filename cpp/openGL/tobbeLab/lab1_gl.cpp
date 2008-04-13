#include "lab1_gl.h"

#include <stdio.h>

lab1_gl_c::lab1_gl_c(QWidget* _pParent,const char* _szName)
:	QGLWidget(_pParent,_szName)
{
	setFocusPolicy(QWidget::StrongFocus);
	m_pTimer = new QTimer(this,0);
	QObject::connect(m_pTimer,SIGNAL(timeout()),this,SLOT(updateGL()));
	m_pTimer->start(10);
	m_Time.start();

	m_pClock = 0;

}

lab1_gl_c::~lab1_gl_c(void)
{
	delete m_pClock;
}

void lab1_gl_c::initializeGL(void)
{
	m_pClock = new clock_c();

	glClearColor(0,0,0,0);
	glClearDepth(1);
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
	glShadeModel(GL_SMOOTH);
}

void lab1_gl_c::resizeGL(int _iWidth,int _iHeight)
{
	if(!_iHeight)
		_iHeight = 1;
	glViewport(0,0,_iWidth,_iHeight);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60,(GLfloat)_iWidth / _iHeight,1,20);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

inline double deg2rad(double _deg)
{
	return _deg * 3.14 / 180.0;
}

const double ColorCycle = 360.0 / 1000.0;

void lab1_gl_c::paintGL(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	static int ttime = 0;
	int delta = m_Time.restart();
	ttime += delta;
	m_sinus.update(delta);
	m_pClock->update(delta);

	m_sinus.setLowColor(0.5f + 0.5*sin(deg2rad(ttime * ColorCycle)) ,0,1);
	m_sinus.setHighColor(0,1,0.5f + 0.5f*cos(deg2rad(ttime * ColorCycle)));


	glTranslatef(0,0,-2.5);
	glRotatef(m_fRotX,1,0,0);
	glRotatef(m_fRotY,0,1,0);
	glRotatef(m_fRotZ,0,0,1);

	m_sinus.draw();

	glLoadIdentity();
	glTranslatef(0,0,-2.5);
	glColor4f(1,1,1,0.33f);
	glEnable(GL_BLEND);
	glDisable(GL_DEPTH_TEST);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	m_pClock->draw();
	glEnable(GL_DEPTH_TEST);
	glDisable(GL_BLEND);

}

void lab1_gl_c::setRendermodeFront(int _iMode)
{
	switch(_iMode)
	{
		case 0:
			glPolygonMode(GL_FRONT,GL_LINE);
			break;
		case 1:
			glPolygonMode(GL_FRONT,GL_FILL);
			break;
		case 2:
			glPolygonMode(GL_FRONT,GL_POINT);
	}
}

void lab1_gl_c::setRendermodeBack(int _iMode)
{
	switch(_iMode)
	{
		case 0:
			glPolygonMode(GL_BACK,GL_LINE);
			break;
		case 1:
			glPolygonMode(GL_BACK,GL_FILL);
			break;
		case 2:
			glPolygonMode(GL_BACK,GL_POINT);
	}
}

void lab1_gl_c::setShadeModel(int _iModel)
{
	switch(_iModel)
	{
		case 0:
			glShadeModel(GL_FLAT);
			break;
		case 1:
			glShadeModel(GL_SMOOTH);
	}
}