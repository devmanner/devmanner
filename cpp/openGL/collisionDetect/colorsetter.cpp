#include "colorsetter.h"

void ColorSetter::setColor2(double z) {
	static double r=0, b=0;
	// Optimization...
	if (z == m_prevz) {
		glColor3f(r, 0, b);
		return;
	}
	m_prevz = z;
	if (z > m_maxz) { // Red over piece
		r = 1; b = 0;
	}
	else if (z < m_minz) { // Blue below piece
		r = 0; b = 1;
	}
	else {
		b = (m_maxz-z)/(m_maxz-m_minz);
		r = 1 - b;
	}
	glColor3f(r, 0, b);
}

/*
* setColor4() : Interpolate between red, yellow, green, cyan and blue.
*/
void ColorSetter::setColor4(double z) {
	static double r=0, g=0, b=0;

	// Optimization.
	if (z == m_prevz) {
		glColor3f(r, g, b);
		return;
	}
	m_prevz = z;

	if (z > m_maxz) { // Red over piece
		r = 1; g = 0; b = 0;
	}
	else if (z < m_minz) { // Blue below piece
		r = 0; b = 1; g = 0;
	}
	else {
		double offset = m_maxz - z; // Distance to maxz.
		static double stepsize = absd(m_maxz - m_minz) / 4; // Only calculated once.
		if (offset < stepsize) {
				r = 1;
				g = 1-absd(offset - stepsize) / stepsize;
				b = 0;
		}
		else if (offset < stepsize*2){
				r = absd(offset - stepsize*2) / stepsize;
				g = 1;
				b = 0;
		}
		else if (offset < stepsize*3){
				r = 0;
				g = 1;
				b = 1-absd(offset - stepsize*3) / stepsize;
		}
		else{
				r = 0;
				g = absd(offset - stepsize*4) / stepsize;
				b = 1;
		} 
	}
	glColor3f(r, g, b);
}

void ColorSetter::toggleColorMode() {
	m_colorFunc = (m_colorFunc == (&ColorSetter::setColor2)) ? (&ColorSetter::setColor4) : (&ColorSetter::setColor2);
}

void ColorSetter::setColor(double z) {
	(this->*m_colorFunc)(z);
}

inline void ColorSetter::setColor(Vertex &v) {
	if (v.m_z != UNDEFINED_VALUE)
		setColor(v.m_z);
}
  
