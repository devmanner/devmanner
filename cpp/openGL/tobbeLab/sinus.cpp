#include "sinus.h"

//#include <windows.h>
#include <GL/gl.h>
#include <math.h>

sinus_c::sinus_c(void)
{
	m_fStepX = 0.1f;
	m_fStepY = 0.1f;
	m_ulOffset = 0;
	m_fPeaksX = m_fPeaksY = 1;
	m_fLowRed = m_fLowGreen = m_fLowBlue = 0;
	m_fHighRed = m_fHighGreen = m_fHighBlue = 1;
}

inline double deg2rad(double _deg)
{
	return _deg * 3.14 / 180.0;
}

inline GLfloat height(float x,float y,float _fXPeaks,float _fYPeaks,float _fOffset)
{
	GLfloat c1 = (GLfloat)(1 - sin(deg2rad(_fOffset + _fXPeaks * x * 360)));
	GLfloat c2 = (GLfloat)(1 - sin(deg2rad(_fOffset + _fYPeaks *y * 360)));
	return (c1 + c2) / 4;
}

void sinus_c::color(float _fZ,GLfloat* _dest)
{
	_dest[0] = m_fLowRed + _fZ * (m_fHighRed - m_fLowRed);
	_dest[1] = m_fLowGreen + _fZ * (m_fHighGreen - m_fLowGreen);
	_dest[2] = m_fLowBlue + _fZ * (m_fHighBlue - m_fLowBlue);
}

void sinus_c::calcQuad(float _fX,float _fY,float _fOffset,GLfloat *_dest)
{
	_dest[3] = -0.5f + _fX;
	_dest[4] = -0.5f + _fY;
	_dest[5] = height(_fX,_fY,m_fPeaksX,m_fPeaksY,_fOffset);
	color(_dest[5],_dest);

	_dest[9] = -0.5f + _fX;
	_dest[10] = -0.5f + _fY - m_fStepY;
	_dest[11] = height(_fX,_fY - m_fStepY,m_fPeaksX,m_fPeaksY,_fOffset);
	color(_dest[11],_dest + 6);

	_dest[15] =	-0.5f + _fX + m_fStepX;
	_dest[16] = -0.5f + _fY;
	_dest[17] = height(_fX + m_fStepX,_fY,m_fPeaksX,m_fPeaksY,_fOffset);
	color(_dest[17],_dest + 12);

	_dest[21] = -0.5f + _fX + m_fStepX;
	_dest[22] = -0.5f + _fY - m_fStepY;
	_dest[23] = height(_fX + m_fStepX,_fY - m_fStepY,m_fPeaksX,m_fPeaksY,_fOffset);
	color(_dest[23],_dest + 18);
}

void sinus_c::draw(void)
{
	glPushMatrix();

	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);

	float fOffset = (float)m_ulOffset / 10;
	GLfloat v[24];	

	for(float y = 1; y > 0; y -= m_fStepY)
		for(float x = 0; x < 1; x += m_fStepX)
		{
			calcQuad(x,y,fOffset,v);
			glInterleavedArrays(GL_C3F_V3F,0,v);
			glDrawArrays(GL_TRIANGLE_STRIP,0,4);
		}
	
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);

	glPopMatrix();
}

void sinus_c::update(unsigned long _ulMSec)
{
	m_ulOffset += _ulMSec;
}

void sinus_c::setLowColor(float _fRed,float _fGreen,float _fBlue)
{
	m_fLowRed = _fRed;
	m_fLowGreen = _fGreen;
	m_fLowBlue = _fBlue;
}

void sinus_c::setHighColor(float _fRed,float _fGreen,float _fBlue)
{
	m_fHighRed = _fRed;
	m_fHighGreen = _fGreen;
	m_fHighBlue = _fBlue;
}
