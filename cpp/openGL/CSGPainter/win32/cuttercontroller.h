#ifndef _CUTTERCONTROLLER_H_
#define _CUTTERCONTROLLER_H_

#include <fstream>
#include <string>
#include <iostream>
#include <vector>
#include "cutterlib.h"
#include "cuttertool.h"
#include "shape.h"
using std::vector;
using std::ifstream;

/*
 * Class:				CutterController
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	A virtual cuttermachine, implemented as a singelton
 * Inheritance:	None
 * Uses:				Vertex			[cutterlib.h]
 * Updated:			2003-05-08 [Tomas Mannerstedt] (Reimplemented it as a "true" singelton)
 */
class CutterController{
private:
  Vertex m_pos, m_min, m_max;				// Current position, maximum and minimum values
  int		m_speed;										// Rotation speed
  int		m_rotDirection;							// Rotation direction
  int		m_tool;											// Current tool
  int		m_orientMode;								// xyz axis orientation mode
  //  bool		m_isAbs;							// Absolute or relative measurements
  bool		m_inchMode;               // Inch or mmm mode?
  bool		m_cooling;                // Is the cooling fluid on?
  double	m_feed;										// Feed speed
	vector<CutterTool *> m_tooltable;

  void adjustMaxMin() ;
  CutterController();

 public:
	~CutterController();
	static CutterController& getInstance() {
		static CutterController c;
		return c;
	}
	// Reset all values to initial values.
	void reset();

  Vertex getPos();
	void setPos(Vertex );
  
  Vertex getMin();
  void setMin(Vertex );
  
  Vertex getMax();
  void setMax(Vertex );
  
  int getSpeed();
  void setSpeed(int );

  double getFeed();
  void setFeed(double );

  CutterTool getTool();
  void setTool(int );
  
  void defineTool(CutterTool );
  void setOrientationMode(int );
  int getOrientationMode();
  
  void setDirection(int );
  int getDirection();
  
  void setInchMode(bool );
  bool getInchMode();
  
  void setCooling(bool );
  bool getCooling();
};

#endif

