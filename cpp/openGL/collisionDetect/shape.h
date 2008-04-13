#ifndef _SHAPE_H_
#define _SHAPE_H_

#include <limits>
#include <math.h>
#include <qgl.h>

#include "colorsetter.h"
#include "cossintable.h"
#include "cutterlib.h"

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

class BoundingBox {
 private:
  Vertex m_max, m_min;

  double max(double d1, double d2) {
    return (d1 > d2) ? d1 : d2;
  }
  double min(double d1, double d2) { 
    return (d1 < d2) ? d1 : d2;
  }

  bool imp_intersects(BoundingBox &);

 public:
  BoundingBox() : m_max(), m_min() {
  }
  ~BoundingBox() {
  }

#ifdef _DEBUG_MODE_
  void drawBBox();
#endif
  void addToBBox(const Vertex &v);
  void addToBBox(double x, double y, double z) {
    addToBBox(Vertex(x, y, z));
  }
  Vertex getMax() {
    return m_max;
  }
  Vertex getMin() {
    return m_min;
  }

  bool intersects(BoundingBox &b) {
    return (this->imp_intersects(b) || b.imp_intersects(*this));
  }
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

class Shape {
 protected:
 public:
  Shape() {}
  virtual ~Shape() {}
  virtual void draw()=0;
#ifdef _DEBUG_MODE_
  virtual void drawBBox()=0;
#endif
  virtual void create()=0;
  virtual bool isPiece()=0;
  virtual bool intersects(BoundingBox &)=0;
  virtual bool intersects(Shape &)=0;
};

/*
 * Class:       ShapeComposite
 * Authour:     Kristoffer Roupé , Tomas Mannerstedt
 * Date:        2003-04-05
 * Description:	Pure virtual baseclass for all the shapes
 * Inheritance:	Shape
 * Uses:	transformation
 * Updated:			
 */

class ShapeComposite : public Shape {
 private:
  Shape *m_s1, *m_s2;
 protected:
 public:
  ShapeComposite(Shape *s1, Shape *s2) : m_s1(s1), m_s2(s2) {}
  ~ShapeComposite() {
    delete m_s1;
    delete m_s2;
  }
#ifdef _DEBUG_MODE_
  void drawBBox() {
    m_s1->drawBBox();
    m_s2->drawBBox();
  }
#endif
  void create() {
    m_s1->create();
    m_s2->create();
  }
  void draw() {
    m_s1->draw();
    m_s2->draw();
  }
  bool isPiece() {
    return (m_s1->isPiece() || m_s2->isPiece());
  }
  bool intersects(BoundingBox &b) {
    return (m_s1->intersects(b) || m_s2->intersects(b));
  }
  bool intersects(Shape &s) {
    return (m_s1->intersects(s) || m_s2->intersects(s));
  }
};

/*
 * Class:	ConcreteShape
 * Authour:	Kristoffer Roupé , Tomas Mannerstedt
 * Date:	2003-04-05
 * Description:	Baseclass for the concrete shapes
 * Inheritance:	Shape
 * Uses:	transformation
 * Updated:			
 */

class ConcreteShape : public Shape{
protected:
  BoundingBox m_boundingBox;
  transformation m_tra;
  float	m_color[4];
  bool m_isPiece;
  GLuint m_list;
  Vertex m_bBoxMax, m_bBoxMin; // Bounding box for collision detection.

public:
  ConcreteShape(float *color=0, bool isPiece=true);
  
  ConcreteShape(float *translation, float *rotation, float *scale, float *color, bool isPiece);
  virtual ~ConcreteShape();

#ifdef _DEBUG_MODE_
  void drawBBox() {
    m_boundingBox.drawBBox();
  }
#endif

  // The interface function.
  bool intersects(BoundingBox &b) {
    return m_boundingBox.intersects(b);
  }
  bool intersects(Shape &s) {
    return s.intersects(m_boundingBox);
  }

  virtual void create()=0;
  virtual void draw();
  
  transformation *getTrans();
  float *getColor();
  bool isPiece();
};


/*
 * Class:	Box
 * Authour:	Kristoffer Roupé , Tomas Mannerstedt
 * Date:	2003-04-10
 * Description:	Baseclass for all the boxshapes
 * Inheritance:	Shape
 * Uses:				
 * Updated:			
 */
class Box : public ConcreteShape{
public:
  Box(float *c, bool isPiece):
    ConcreteShape(c,isPiece){ }
};

/*
 * Class:	StraightBox
 * Authour:	Kristoffer Roupé , Tomas Mannerstedt
 * Date:	2003-04-10
 * Description:	A box that is defined by CutterControllers max/min Vertexes
 * Inheritance:	Box
 * Uses:	Vertex
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
 * Class:	GayBox
 * Authour:	Kristoffer Roupé , Tomas Mannerstedt
 * Date:	2003-04-14
 * Description:	A box that is defined by CutterControllers currentpos (lower) and
 *		the endpos (lower). It is possible to draw a GayBox's start and end
 *		with diffrent depths. The angle for the box is depending on the line
 *		between the to Vertexes.
 * Inheritance:	Box
 * Uses:	Vertex
 * Updated:			
 */
class GayBox : public ConcreteShape{
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
class Quadric : public ConcreteShape{
protected:
	  GLUquadricObj	*m_quadric;
public:
	Quadric(float *c=0, bool isPiece=false) : ConcreteShape(c,isPiece){
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
  GLfloat m_r, m_h; // Radius and height
 public:
  Cylinder(Vertex bottomCenter, GLfloat d, GLfloat h, GLfloat *c=0, bool isPiece=false);
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

