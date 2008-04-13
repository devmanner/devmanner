#ifndef _COSSINTABLE_H_
#define _COSSINTABLE_H_
#include <math.h>
#include "cutterlib.h"

/*
 * Class:				CosSinTable
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-05-08
 * Description:	Singelton that set up 2 tables containing sin and cos values
 * Inheritance:	None
 * Updated:
 */
class CosSinTable{
private:
	double m_sintable[360];
	double m_costable[360];
	CosSinTable(){
		for(int i=0; i < 360; i++){
			m_sintable[i] = ::sin(i* M_PI/180);
			m_costable[i] = ::cos(i* M_PI/180);
		}
	}
public:
	static CosSinTable &getInstance(){
		static CosSinTable cst;
		return cst;
	}
	inline double sin(int angle)	{ return m_sintable[angle%360]; }
	inline double cos(int angle)	{ return m_costable[angle%360]; }
};

#endif