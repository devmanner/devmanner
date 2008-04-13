
#ifndef _COLORSETTER_H_
#define _COLORSETTER_H_

#include <qgl.h>
#include "cutterlib.h"
#include "cuttercontroller.h"

//class CutterController;
/*
 * Class:				ColorSetter
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-05-08
 * Description:	Singelton that calculates color depending on depth (z-axis)
 * Inheritance:	None
 * Updated:
 */

class ColorSetter {
private:
  bool m_edgesDefined;		// Are max and min defined yet?
  double m_maxz;					// Maximum z-value, taken from CutterController.
  double m_minz;					// Minimum z-value, taken from CutterController.
  double m_prevz;					// The Previous z-value (used for optimization).
  void (ColorSetter::*m_colorFunc)(double); // The color function currently used.

  ColorSetter() :
    m_edgesDefined(false), m_maxz(UNDEFINED_VALUE), m_minz(UNDEFINED_VALUE), m_prevz(UNDEFINED_VALUE), m_colorFunc(&ColorSetter::setColor2)
		{ }

  /*
   * setColor2() : Interpolate between red and blue.
   */
  void setColor2(double );
  
  /*
   * setColor4() : Interpolate between red, yellow, green, cyan and blue.
   */
  void setColor4(double );

public:
	static ColorSetter& getInstance() {
		static ColorSetter cs;
		
		if (!cs.m_edgesDefined) {
//			CutterController::getInstance();
			/*
			m_maxz = CutterController::getInstance().getMax().m_z;
			m_minz = CutterController::getInstance().getMin().m_z;
			*/
			if (cs.m_maxz != UNDEFINED_VALUE && cs.m_maxz != UNDEFINED_VALUE)
				cs.m_edgesDefined = true;
		}

		return cs;
	}

	// Change th functionpointer to the other function.
  void toggleColorMode();
	// Call either setColor2(double) or setColor4(double) via the function pointer.
  void setColor(double );
  inline void setColor(Vertex &);
  
};

#endif
