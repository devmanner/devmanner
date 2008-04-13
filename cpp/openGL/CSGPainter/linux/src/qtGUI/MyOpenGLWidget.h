#ifndef _MYOPENGLWIDGET_H_
#define _MYOPENGLWIDGET_H_

#include <qgl.h>
#include "../csgpainter.h"

class MyOpenGLWidget : public QGLWidget{
	Q_OBJECT        // must include this if you use Qt signals/slots
private:
	QTimer *timer;
	bool	m_csg,		m_color;
	float m_xrot,		m_yrot,		m_zrot;
	float m_zoomx,	m_zoomy,	m_zoomz;

protected:
	void mousePressEvent ( QMouseEvent * e );
	void keyPressEvent ( QKeyEvent * e );
	void initializeGL();
	void resizeGL( int w, int h );
	void paintGL();
public:
   MyOpenGLWidget( int timerDelay=10 /* 100 FPS */, QWidget *parent=0, const char *name=0 );
	 void setZoom(float x, float y, float z){
		m_zoomx = x;
		m_zoomy = y;
		m_zoomz = z;
	}
};

#endif


