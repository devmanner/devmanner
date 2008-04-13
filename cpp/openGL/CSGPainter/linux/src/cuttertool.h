#ifndef _CUTTERTOOL_H_
#define _CUTTERTOOL_H_

#include <iostream>

using std::cout;
using std::endl;

/*
 * Class:				CutterTool
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-10
 * Description:	A container to hold information about a tool
 * Inheritance:	None
 * Uses:		
 * Updated:
 */
class CutterTool {
private:
	int m_toolNo;
	double m_length, m_radius;
public:
	CutterTool(int n, double l, double r) : m_toolNo(n), m_length(l), m_radius(r) { }
	void print() { 
#ifdef _DEBUG_MODE_ 
		printf("Tool: %d length: %.2f radius: %.2f\n", m_toolNo,m_length, m_radius); 
#endif
	}
	void setNo(int n) { m_toolNo = n; }
	void setLength(double l) { m_length = l; }
	void setRadius(double r) { m_radius = r; }
	int			getNo()			{ return m_toolNo; }
	double	getLength() { return m_length; }
	double	getRadius() { return m_radius; }
	
};

#endif

