#ifndef _CUTTERCOMMAND_H_
#define _CUTTERCOMMAND_H_

#include <iostream>
#include "cutterlib.h"
#include "cuttercontroller.h"
#include "csgpainter.h"
/*
 * Class:				CutterCommand
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Pure virtual baseclass for Commands invoking the cutter
 * Inheritance:	None
 * Updated:
 */
class CutterCommand{
protected:
	unsigned int m_rowNo;
public:
	CutterCommand(int row)
	  : m_rowNo(row){}
	virtual ~CutterCommand(){}
	virtual void execute()=0;
	unsigned int getRow() {
		return m_rowNo;
	}
};

/*
 * Class:				LiearMovementCommand
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Command for linear movements
 * Inheritance:	CutterCommand
 * Uses:				Vertex			[cutterlib.h]
 * Updated:
 */
class LinearMovementCommand : public CutterCommand{
private:
	Vertex m_end;
	bool m_workSpeed;
public:
	LinearMovementCommand(int row, Vertex end, bool workSpeed)
	  : CutterCommand(row), m_end(end), m_workSpeed(workSpeed) { }
	virtual void execute(){
		// Get the current position to specify the third, not defined position.
		Vertex cpos = CutterController::getInstance().getPos();
		if (m_end.m_x == UNDEFINED_VALUE) m_end.m_x = cpos.m_x;
		if (m_end.m_y == UNDEFINED_VALUE) m_end.m_y = cpos.m_y;
		if (m_end.m_z == UNDEFINED_VALUE) m_end.m_z = cpos.m_z;

		// add a cyliner from the toolbox at starting pos to painter
		float color[] = {0.5,0.2,0.2};

		// Movement along z axis
		if(cpos.m_x == m_end.m_x && cpos.m_y == m_end.m_y){
			Shape *cyl = new Cylinder((cpos.m_z < m_end.m_z)?cpos:m_end,CutterController::getInstance().getTool().getRadius()/2, absd(cpos.m_z - m_end.m_z), color, false);
			cyl->create();
			CSGPainter::getInstance().add(cyl);
		}
		else{
			Shape *cyl = new Cylinder(cpos,CutterController::getInstance().getTool().getRadius()/2, absd(CutterController::getInstance().getMax().m_z - m_end.m_z), color, false);
			cyl->create();
			CSGPainter::getInstance().add(cyl);
			Shape *box = new GayBox(cpos, m_end, CutterController::getInstance().getTool().getRadius(), CENTER, color, false);
			box->create();
			CSGPainter::getInstance().add(box);
			cyl = new Cylinder(m_end,CutterController::getInstance().getTool().getRadius()/2, absd(CutterController::getInstance().getMax().m_z - m_end.m_z), color, false);
			cyl->create();
			CSGPainter::getInstance().add(cyl);
		}
#ifdef _DEBUG_MODE_
		printf("LinearMovementCommand::execute() -> ");
#endif
		m_end.print();
#ifdef _DEBUG_MODE_
		printf(" with speed %s speed.\n" ,((m_workSpeed) ? "transport" : "work"));
#endif
		CutterController::getInstance().setPos(m_end);
	}
};

/*
 * Class:				CircularMovementCommand
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Command for circular movements
 * Inheritance:	CutterCommand
 * Uses:				Vertex			[cutterlib.h]
 * Updated:
 */
class CircularMovementCommand : public CutterCommand{
private:
	Vertex m_end;			// The end position of the cut.
	Vertex m_circMid;	// The midpoint of the circle. Relative.
	bool m_clockwise;	// Clockwise or counter-clockwise.
public:
	CircularMovementCommand(int row, Vertex end, Vertex mid, bool cw)
	  : CutterCommand(row), m_end(end), m_circMid(mid), m_clockwise(cw) {}
	virtual void execute(){
		Vertex cpos = CutterController::getInstance().getPos();
		if (m_end.m_x == UNDEFINED_VALUE) m_end.m_x = cpos.m_x;
		if (m_end.m_y == UNDEFINED_VALUE) m_end.m_y = cpos.m_y;
		if (m_end.m_z == UNDEFINED_VALUE) m_end.m_z = cpos.m_z;

		// Calculate the exact coordinates of the circle midpoint.
		Vertex cmid(m_circMid);
		if (cmid.m_x == UNDEFINED_VALUE) 
			cmid.m_x = cpos.m_x;
		
		if (cmid.m_y == UNDEFINED_VALUE) 
			cmid.m_y = cpos.m_y;
		
		if (cmid.m_z == UNDEFINED_VALUE) 
			cmid.m_z = cpos.m_z;

#ifdef _DEBUG_MODE_		
		printf("CircularMovementCommand::execute()\n");
#endif

		float color[] = {0.5,0.2,0.2};

		double startangle = cpos.xyAngle(cmid);
		double endangle = m_end.xyAngle(cmid);
		double sweepangle = 0.0;
		if(startangle > 0 ||( startangle < 0 && endangle < 0))
			sweepangle = startangle - endangle;
		else
			sweepangle = 360 + startangle - endangle;

		if(sweepangle < 0)
			sweepangle += 360;
#ifdef _DEBUG_MODE_
		printf("cpos: ");cpos.print();
		printf("\nm_end: ");m_end.print();
		printf("\ncmid: ");cmid.print();
		printf("\nsweepangle: %.2f\n", sweepangle);
#endif
		Shape *arc = new SolidArc(cmid, m_clockwise, absd(cpos.m_y - m_circMid.m_y - CutterController::getInstance().getTool().getRadius()/2), 
			absd(cpos.m_y - m_circMid.m_y + CutterController::getInstance().getTool().getRadius()/2), 
			startangle, sweepangle, 
			(CutterController::getInstance().getMax().m_z - cmid.m_z) + SMALL_DBL, color, false);
		arc->create();
		CSGPainter::getInstance().add(arc);

		/*Shape *cyl = new Cylinder(Vertex(m_end.m_x, m_end.m_y,CutterController::getInstance().getMax().m_z + SMALL_DBL), 
																	   4, CutterController::getInstance().getMax().m_z - m_end.m_z, color, false);
		cyl->create();
		CSGPainter::getInstance().add(cyl);*/

		CutterController::getInstance().setPos(m_end);
	}
};

/*
 * Class:				ControlUpdateCommand
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Command for updateing the CutterController
 * Inheritance:	CutterCommand
 * Uses:		
 * Updated:
 */
template <typename T>
class ControlUpdateCommand : public CutterCommand{
private:
	T m_value;
	void (CutterController::*m_func)(T);
public:
	ControlUpdateCommand(int row, T value, void (CutterController::*ptr)(T))
	  : CutterCommand(row),  m_value(value), m_func(ptr){}
	virtual void execute(){
		cout << "ControlUpdateCommand::execute() -> ngt ;)"<< endl;
		(CutterController::getInstance().*m_func)(m_value);
	}
};


#endif

