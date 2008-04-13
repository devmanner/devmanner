#ifndef _SINUS_INCLUDED_
#define _SINUS_INCLUDED_

class sinus_c
{
	float m_fStepX;
	float m_fStepY;

	unsigned long m_ulOffset;

	float m_fPeaksX;
	float m_fPeaksY;

	float m_fLowRed;
	float m_fLowGreen;
	float m_fLowBlue;
	float m_fHighRed;
	float m_fHighGreen;
	float m_fHighBlue;

public:
	sinus_c(void);

	void draw(void);
	void update(unsigned long _ulMSec);

	void setStepsX(int _iStepsX){ m_fStepX = (float)(1.0 / _iStepsX);}
	void setStepsY(int _iStepsY){ m_fStepY = (float)(1.0 / _iStepsY);}
	void setPeaksX(int _iPeaksX){ m_fPeaksX = (float)(_iPeaksX);}
	void setPeaksY(int _iPeaksY){ m_fPeaksY = (float)(_iPeaksY);}
	void setLowColor(float _fRed,float _fGreen,float _fBlue);
	void setHighColor(float _fRed,float _fGreen,float _fBlue);

protected:
	void color(float _fZ,float *_dest);
	void calcQuad(float _fX, float _fY, float _fOffset,float *_dest);
};

#endif