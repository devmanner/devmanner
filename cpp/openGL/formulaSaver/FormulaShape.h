#ifndef _FORMULA_SHAPE_H_
#define _FORMULA_SHAPE_H_

#include <math.h>
#include <stdio.h>

struct Point {
  GLfloat x, y, z;

  Point() { }
  Point(GLfloat X, GLfloat Y, GLfloat Z) : x(X), y(Y), z(Z) { }
  Point(const Point &p) : x(p.x), y(p.y), z(p.z) { }

  double norm() const { 
    return sqrt(x*x + y*y + z*z);
  }

  Point normalize() { 
    if(norm() != 0.0)
      return Point(this->x/norm(), this->y/norm(), this->z/norm());
    else{
      *this = Point(0,1,0);
      return *this;
    }
  }
};


// Base class for all formula shapes.
class FormulaShape {
 public:
  FormulaShape() {
  }
  virtual ~FormulaShape() {
  }
  virtual void draw()=0;
  virtual void reshape()=0;
  virtual void setViewport()=0;
};

// A Klein Bottle
class KleinBottle : public FormulaShape {
 private:
  GLfloat m_scale;
  GLuint m_list;
 public:

  KleinBottle() : m_scale(0.1), m_list(0) {
    m_list = glGenLists(1);
    glNewList(m_list, GL_COMPILE);
    glPushMatrix();

    glScalef(m_scale, m_scale, m_scale);
    glBegin(GL_TRIANGLES);
    double x[4], y[4], z[4];
    int passes = 0;
    for (double v = 0; v < 2 * M_PI; v += 0.1) { // Small circle
      for (double u = 0; u < 2 * M_PI; u += 0.1) {
	double r1 = 4 * (1 - cos(u)/2);
	double r2 = 4 * (1 - cos(u-.1)/2);
	if (u < M_PI) {
	  x[0] = 6*cos(u)*(1+sin(u)) + r1*cos(u)*cos(v);
	  y[0] = 16*sin(u) + r1*sin(u)*cos(v);
	  
	  x[1] = 6*cos(u-.1)*(1+sin(u-.1)) + r1*cos(u-.1)*cos(v);
	  y[1] = 16*sin(u-.1) + r1*sin(u-.1)*cos(v);
	  
	  x[2] = 6*cos(u)*(1+sin(u)) + r1*cos(u)*cos(v-.1);
	  y[2] = 16*sin(u) + r1*sin(u)*cos(v-.1);

	  x[3] = 6*cos(u-.1)*(1+sin(u-.1)) + r2*cos(u-.1)*cos(v-.1);
	  y[3] = 16*sin(u-.1) + r2*sin(u-.1)*cos(v-.1);
	}
	else {
	  x[0] = (6*cos(u)) * (1 + sin(u))+ r1*cos(v+M_PI);
	  y[0] = 16*sin(u);

	  x[1] = (6*cos(u-.1)) * (1 + sin(u-.1))+ r1*cos(v+M_PI);
	  y[1] = 16*sin(u-.1);

	  x[2] = (6*cos(u)) * (1 + sin(u))+ r1*cos(v-.1+M_PI);
	  y[2] = 16*sin(u);

	  x[3] = (6*cos(u-.1)) * (1 + sin(u-.1))+ r2*cos(v-.1+M_PI);
	  y[3] = 16*sin(u-.1);
	}
	z[0] = r1*sin(v);
	z[1] = r1*sin(v);
	z[2] = r2*sin(v-.1);
	z[3] = r2*sin(v-.1);

	switch(passes) {
	case 0: glColor3f(1, 0, 0); break;
	case 1: glColor3f(0, 1, 0); break;
	case 2: glColor3f(0, 0, 1); break;
	case 3: glColor3f(0, 1, 1); break;
	case 4: glColor3f(1, 0, 1); break;
	default: passes = -1;
	}
	++passes;

	glVertex3f(x[0], y[0], z[0]);
	glVertex3f(x[1], y[1], z[1]);
	glVertex3f(x[2], y[2], z[2]);

	glVertex3f(x[1], y[1], z[1]);
	glVertex3f(x[2], y[2], z[2]);
	glVertex3f(x[3], y[3], z[3]);
      }
    }
    glEnd();
    glPopMatrix();
    glEndList(); 
  }

  /*
  KleinBottle() : m_scale(0.1), m_list(0) {
    m_list = glGenLists(1);
    glNewList(m_list, GL_COMPILE);
    glPushMatrix();
    //glTranslatef( 0.0, 0.0, -3.0 );
    glScalef(m_scale, m_scale, m_scale);
    glBegin(GL_QUAD_STRIP);
    glColor3f(1, 0, 0);
    int i = 0;
    for (double v = 0; v < 2 * M_PI; v += 0.1) { // Small circle
      for (double u = 0; u < 2 * M_PI; u += 0.1, i = (i + 1) % 4) {
	double r1 = 4 * (1 - cos(u)/2);
	double r2 = 4 * (1 - cos(u-.1)/2);
	double x1, y1, x2, y2, z1, z2;
	if (u < M_PI) {
	  x1 = 6*cos(u)*(1+sin(u)) + r1*cos(u)*cos(v);
	  y1 = 16*sin(u) + r1*sin(u)*cos(v);
	  x2 = 6*cos(u-.1)*(1+sin(u-.1)) + r2*cos(u-.1)*cos(v-.1);
	  y2 = 16*sin(u-.1) + r2*sin(u-.1)*cos(v-.1);
	} else {
	  x1 = (6*cos(u)) * (1 + sin(u))+ r1*cos(v+M_PI);
	  y1 = 16*sin(u);
	  x2 = (6*cos(u-.1)) * (1 + sin(u-.1))+ r2*cos(v-.1+M_PI);
	  y2 = 16*sin(u-.1);
	}
	z1 = r1*sin(v);	z2 = r2*sin(v-.1);
	switch (i){
	case 0: glColor3f(1, 0, 0); break;
	case 1: glColor3f(1, 1, 0); break;
	case 2: glColor3f(0, 1, 0); break;
	case 3: glColor3f(0, 1, 1); break;
	case 4: glColor3f(0, 0, 1); break;
	case 5: glColor3f(1, 1, 1); break;
	}
	
	//glColor3f(v/M_PI, u/M_PI, 1);
	glVertex3f(x1, y1, z1);
	glVertex3f(x2, y2, z2);
      }
    }
    glEnd();
    glPopMatrix();
    glEndList(); 
  }
*/
  void draw() {
    glCallList(m_list);
  }

  void reshape() {}
  void setViewport() {
    glTranslatef( 0.0, 0.0, -3.0 );
    glScalef( m_scale, m_scale, m_scale );
  }
};






class SphericalHarmonics : public FormulaShape {
 private:
  GLfloat m_scale;
  GLuint m_list;
  int m_m[7];
 
  Point CalcNormal(Point p1, Point p2, Point p3) {
    Point pv1(p1.x-p2.x, p1.y-p2.y, p1.z-p2.z); // Plane vector 1
    Point pv2(p1.x-p3.x, p1.y-p3.y, p1.z-p3.z); // Plane vector 2
    Point cross(pv1.y*pv2.z-pv1.z*pv2.y,
		pv1.z*pv2.x-pv1.x*pv2.z,
		pv1.x*pv2.y-pv1.y*pv2.x); // Linjär algebra med vektorgeometri s. 109
    return cross.normalize();
  }

  Point Eval(double theta, double phi) {
    double r = 0;
    Point p;
    r += pow(sin(m_m[0]*phi),(double)m_m[1]);
    r += pow(cos(m_m[2]*phi),(double)m_m[3]);
    r += pow(sin(m_m[4]*theta),(double)m_m[5]);
    r += pow(cos(m_m[6]*theta),(double)m_m[7]);
    p.x = r * sin(phi) * cos(theta);
    p.y = r * cos(phi);
    p.z = r * sin(phi) * sin(theta);
    return(p);
  }

 public:
  SphericalHarmonics() : m_scale(0.6), m_list(0) {
    // Fill m with some random numbers...
    for (int i = 0; i < 7; ++i)
      m_m[i] = rand() % 360;

    m_list = glGenLists(1);
    glNewList(m_list, GL_COMPILE);
    glPushMatrix();
    glScalef(m_scale, m_scale, m_scale);

    int resolution = 30;
    double du = 2*M_PI / (double)resolution; /* Theta */
    double dv = M_PI / (double)resolution;    /* Phi   */
    
    glBegin(GL_QUADS);
    Point q[4];
    Point n[4];
    for (int i=0;i<resolution;i++) {
      double u = i * du;
      for (int j=0;j<resolution;j++) {
	double v = j * dv;
	q[0] = Eval(u,v);
	n[0] = CalcNormal(q[0], Eval(u+du/10, v), Eval(u, v+dv/10));
	//c[0] = GetColour(u, 0.0, 2*M_PI, colourmap);
	glNormal3f(n[0].x, n[0].y, n[0].z);
	glColor3f(1, 0, 0);
	//glColor3f(c[0].r, c[0].g, c[0].b);
	glVertex3f(q[0].x, q[0].y, q[0].z);
	
	q[1] = Eval(u+du,v);
	n[1] = CalcNormal(q[1], Eval(u+du+du/10, v), Eval(u+du, v+dv/10));
	//c[1] = GetColour(u+du,0.0,2*M_PI,colourmap);
	glNormal3f(n[1].x,n[1].y,n[1].z);
	//glColor3f(c[1].r,c[1].g,c[1].b);
	glColor3f(0, 1, 0);
	glVertex3f(q[1].x,q[1].y,q[1].z);
	
	q[2] = Eval(u+du, v+dv);
	n[2] = CalcNormal(q[2], Eval(u+du+du/10, v+dv), Eval(u+du, v+dv+dv/10));
	//c[2] = GetColour(u+du,0.0,2*M_PI,colourmap);
	glNormal3f(n[2].x,n[2].y,n[2].z);
	//glColor3f(c[2].r,c[2].g,c[2].b);
	glColor3f(0, 0, 1);
	glVertex3f(q[2].x,q[2].y,q[2].z);
	
	q[3] = Eval(u,v+dv);
	n[3] = CalcNormal(q[3], Eval(u+du/10, v+dv), Eval(u, v+dv+dv/10));
	//c[3] = GetColour(u,0.0,2*M_PI,colourmap);
	glNormal3f(n[3].x,n[3].y,n[3].z);
	//glColor3f(c[3].r,c[3].g,c[3].b);
	glColor3f(1, 1, 0);
	glVertex3f(q[3].x,q[3].y,q[3].z);
      }
    }
    glEnd();
    glPopMatrix();
    glEndList();
  }
  
  void draw() {
    glCallList(m_list);
  }

  void reshape() {}
  void setViewport() {
    //    glTranslatef( 0.0, 0.0, -3.0 );
    glScalef( m_scale, m_scale, m_scale );
  }
};

#endif
