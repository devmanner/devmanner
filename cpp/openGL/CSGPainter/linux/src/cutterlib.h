#ifndef _CUTTERLIB_H_
#define _CUTTERLIB_H_

#include <qgl.h>
#include <iostream>
#include <limits>
#include "cutterexceptions.h"

#ifdef WIN32 // solves MSVC++ 6.0 bug (by: Torbjörn Gyllebring)
#define for if(1)for
#endif

//#define _DEBUG_MODE_

#define LEFT 0
#define CENTER 1
#define RIGHT 2

#ifndef M_PI
#define M_PI 3.141592653589793238
#endif

#ifndef DBL_MAX
const double DBL_MAX = std::numeric_limits<double>::max();
#endif

const double SMALL_DBL = 0.01;
const double UNDEFINED_VALUE = DBL_MAX;

double toDeg(const double &);
double absd(const double &);

/*
 * Class:				Vertex
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Simular to a mathematical vector. Often used to 
 *							draw or calulate things by shapes or commands.
 * Inheritance:	None
 * Updated:			2003-05-02 [Kristoffer Roupé] (Added the draw function)
 *							2003-05-05 [Kristoffer Roupé] (Added the angle function)
 *							2003-05-05 [Kristoffer Roupé] (Added the operator- function)
 */	
struct Vertex{ 
	double m_x, m_y, m_z;
	Vertex(double x=UNDEFINED_VALUE, double y=UNDEFINED_VALUE, double z=UNDEFINED_VALUE) : m_x(x), m_y(y), m_z(z) { }
	void print(){
#ifdef _DEBUG_MODE_
		if(m_x == UNDEFINED_VALUE)
			printf("[U");
		else
			printf("[%.2f", m_x);
		if(m_y == UNDEFINED_VALUE)
			printf(",U,");
		else
			printf(",%.2f,", m_y);
		if(m_z == UNDEFINED_VALUE)
			printf("U]");

		else
			printf("%.2f]", m_z);
#endif
	}
	void draw(){
		glVertex3f(m_x, m_y, m_z);
	}
	double xyAngle(Vertex v){
		Vertex sub = *this - v;
		double alpha = toDeg(acos(sub.m_x / sqrt(sub.m_x*sub.m_x + sub.m_y*sub.m_y)));
		alpha = (sub.m_y < 0)? -alpha : alpha;
#ifdef _DEBUG_MODE_
		printf("sub :");sub.print();printf(" alpha: %.2f\n", alpha);
#endif
		return alpha;
	}
	Vertex operator-(const Vertex &v){
		return Vertex(m_x - v.m_x, m_y - v.m_y, m_z - v.m_z);
	}
};


#endif


