#ifndef _LAB1_GL_H_INCLUDED_
#define _LAB1_GL_H_INCLUDED_

#include <qgl.h>
#include <qtimer.h>
#include <qdatetime.h>
#include <math.h>

#include "sinus.h"
#include "clock.h"

class lab1_gl_c : public QGLWidget
{
	Q_OBJECT;

	QTimer *m_pTimer;
	QTime m_Time;

	sinus_c m_sinus;
	clock_c *m_pClock;
	float m_fRotX, m_fRotY, m_fRotZ;


public:
	lab1_gl_c(QWidget* _pParent,const char* _szName);
	~lab1_gl_c(void);
public slots:
	void initializeGL(void);
	void paintGL(void);
	void resizeGL(int _iWidth,int _iHeight);

	void setRendermodeFront(int _iMode);
	void setRendermodeBack(int _iMode);
	void setShadeModel(int _iModel);

	void setPeaksX(int _iPeaks){ m_sinus.setPeaksX(_iPeaks);}
	void setPeaksY(int _iPeaks){ m_sinus.setPeaksY(_iPeaks);}
	void setStepsX(int _iSteps){ m_sinus.setStepsX(_iSteps);}
	void setStepsY(int _iSteps){ m_sinus.setStepsY(_iSteps);}
	void setRotX(int _iRot){ m_fRotX = (float)_iRot;}
	void setRotY(int _iRot){ m_fRotY = (float)_iRot;}
	void setRotZ(int _iRot){ m_fRotZ = (float)_iRot;}
};

#endif