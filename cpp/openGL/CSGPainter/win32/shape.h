#ifndef _SHAPE_H_
#define _SHAPE_H_

#include <limits>
#include <math.h>
#include <qgl.h>

#include "colorsetter.h"
#include "cuttercontroller.h"
#include "cossintable.h"


/*
 * Class:				transformation
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-18
 * Description:	Used by CSGPainter to manage transformations on Shapes
 * Inheritance:	None
 * Uses:		
 * Updated:
 */
class transformation{
public:
  float	translation[3];
  float	rotation[4];
  float	scale[3];
};

/*
 * Class:				Shape
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-05
 * Description:	Pure virtual baseclass for all the shapes
 * Inheritance:	None
 * Uses:				transformation
 * Updated:			
 */
class Shape{
protected:
  transformation m_tra;
  float	m_color[4];
  bool m_isPiece;
  GLuint m_list;
 public:
  Shape(float *color=0, bool isPiece=true);
  
  Shape(float *translation, float *rotation, float *scale, float *color, bool isPiece);
  virtual ~Shape();
  
  virtual void create()=0;
  virtual void draw();
  
  transformation *getTrans();
  float *getColor();
  bool isPiece();
};


/*
 * Class:				Box
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-10
 * Description:	Baseclass for all the boxshapes
 * Inheritance:	Shape
 * Uses:				
 * Updated:			
 */
class Box : public Shape{
public:
  Box(float *c, bool isPiece):
    Shape(c,isPiece){ }
};

/*
 * Class:				StraightBox
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-10
 * Description:	A box that is defined by CutterControllers max/min Vertexes
 * Inheritance:	Box
 * Uses:				Vertex
 * Updated:			
 */
class StraightBox : public Box{
 private:
  Vertex m_min, m_max;
  
  double m_zOffset;
 public:
  StraightBox(Vertex min, Vertex max, float *c=0, bool isPiece=true);
  void create();
};

/*
 * Class:				GayBox
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-14
 * Description:	A box that is defined by CutterControllers currentpos (lower) and
 *							the endpos (lower). It is possible to draw a GayBox's start and end
 *							with diffrent depths. The angle for the box is depending on the line
 *							between the to Vertexes.
 * Inheritance:	Box
 * Uses:				Vertex
 * Updated:			
 */
class GayBox : public Shape{
  Vertex m_back1, m_back2;
  double m_width;
  int m_alignment;
  double m_alpha;
  double m_length;
  double m_zoffset;
 public:
  GayBox(Vertex b1, Vertex b2,double width, int alignment, float *c, bool isPiece);
  void create();
  void print();
};

/*
 * Class:				Quadric
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-05-09
 * Description:	Baseclass for all the Shapes that uses a GLUquadricObj
 * Inheritance:	Shape
 * Uses:				GLUquadricObj
 * Updated:			
 */
class Quadric : public Shape{
protected:
	  GLUquadricObj	*m_quadric;
public:
	Quadric(float *c=0, bool isPiece=false) : Shape(c,isPiece){
		m_quadric = gluNewQuadric();
	}
	virtual ~Quadric(){
		gluDeleteQuadric(m_quadric);
	}
};

/*
 * Class:				Cylinder
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-20
 * Description:	Draws a Cylinder from bottomCenter with diameter d to the height h
 * Inheritance:	Quadric
 * Uses:				GLUquadricObj
 * Updated:			2003-05-09 [Kristoffer Roupé] (Changed the inheritance to Quadric from Shape)
 */
class Cylinder : public Quadric{
  Vertex m_bottomCenter;
  GLfloat m_d, m_h;
 public:
  Cylinder(Vertex bottomCenter, GLfloat d, GLfloat h, GLfloat *c=0, bool isPiece=false);
  void create();
};

/*
 * Class:				Cone
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-20
 * Description:	Draws a Cone [only for testing]
 * Inheritance:	Quadric
 * Uses:				GLUquadricObj
 * Updated:			2003-05-09 [Kristoffer Roupé] (Changed the inheritance to Quadric from Shape)
 */
class Cone: public Quadric{
 private:
 public:
  Cone(float *c, bool isPiece):
    Quadric(c,isPiece){ }
  void create();
};

/*
 * Class:				Sphere
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-20
 * Description:	Draws a Sphere [only for testing]
 * Inheritance:	Quadric
 * Uses:				GLUquadricObj
 * Updated:			2003-05-09 [Kristoffer Roupé] (Changed the inheritance to Quadric from Shape)
 */
class Sphere : public Quadric{
 public:
  Sphere(float *c, bool isPiece):
    Quadric(c,isPiece){ }
  void create();
};


/*
 * Class:				Arc
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-20
 * Description:	Draws an arc from startangle to endangle with a centerpoint (low) at 
 *							bottomCenter [ startangle changed from 90 -> 0 by adding 270 deg in constructor ]
 * Inheritance:	Quadric
 * Uses:				GLUquadricObj
 * Updated:			2003-05-09 [Kristoffer Roupé] (Changed the inheritance to Quadric from Shape)
 */
class SolidArc : public Quadric {
private:
  Vertex m_bottomCenter;
  bool m_clockwise;
  GLdouble m_innerRadius, m_outerRadius, m_startAngle, m_sweepAngle;
  GLfloat m_height;
public:
  SolidArc(Vertex bottomCenter, bool clockwise, GLdouble innerRadius, GLdouble outerRadius, GLdouble startAngle, GLdouble sweepAngle, GLfloat height, float *c=0, bool isPiece=false);
  ~SolidArc() { }
  void create();
};

#endif

