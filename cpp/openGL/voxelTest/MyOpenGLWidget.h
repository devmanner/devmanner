#include <qgl.h>

class MyOpenGLWidget : public QGLWidget
{
	Q_OBJECT        // must include this if you use Qt signals/slots

public:
   MyOpenGLWidget( int timerDelay=10 /* 100 FPS */, QWidget *parent=0, const char *name=0 );

protected:
	void mousePressEvent ( QMouseEvent * e );
	void keyPressEvent ( QKeyEvent * e );
	void initializeGL();
	void resizeGL( int w, int h );
	void paintGL();
	void drawVox();

private:
	QTimer *timer;
	GLfloat m_scale;
	GLfloat m_xRot, m_yRot, m_zRot;
	GLfloat m_voxSize;
};
