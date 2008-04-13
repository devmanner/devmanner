#ifndef _SHAPE_COMPOSITE_H_
#define _SHAPE_COMPOSITE_H_

#include <vector>
#include <qgl.h>
#include <math.h>

#include "GLError.h"

class ShapeCont {
 private:
  std::vector<GLuint> m_objects;
 public:
  ShapeCont() : m_objects() { }
  /*
   * Adds a vertically placed cylinder between 1 and 2 with diameter d.
   */
  void addCylinder(GLfloat x, GLfloat y, GLfloat z, GLfloat d, GLfloat h) {
    GLuint l = glGenLists(1);
    GLUquadricObj *quadobj = gluNewQuadric();
    // Calculate number of slices in cylinder.
    GLuint slices = (GLuint) (d > 1) ? (GLuint)(d+0.5)*(GLuint)(d+0.5)*10 : 30;
    glNewList(l, GL_COMPILE);
      glPushMatrix(); 
        // Rotate som the cyliner is papinted along the y-axis.
        glRotatef(90, 1.0, 0.0, 0.0);
        glTranslatef(x, y, z);
	glColor3f(1.0, 0.0, 0.0);
	// Top.
	gluDisk(quadobj, 0.0, d/2, slices, 1);
	glColor3f(1.0, 1.0, 0.0);
	// Cyliner.
	gluCylinder(quadobj, d/2.0, d/2.0, h, slices, 10); // 10 10 ???
	glTranslatef(0, 0, h);
	glColor3f(1.0, 0.0, 1.0);
	// Bottom.
	gluDisk(quadobj, 0.0, d/2, slices, 10);
      glPopMatrix();
    glEndList();

    m_objects.push_back(l);
    gluDeleteQuadric(quadobj);
  }

  /*
   * Add a cube between lines between 1&2 and 3&4.
   */
void addCube(GLfloat x1, GLfloat y1, GLfloat z1, GLfloat x2, GLfloat y2, GLfloat z2,
	     GLfloat x3, GLfloat y3, GLfloat z3, GLfloat x4, GLfloat y4, GLfloat z4,
	     GLfloat width, bool debug=0) {
    GLuint l = glGenLists(1);
    // Angle between upper line and x-axis.
    double alpha = (acos((x1-x2)/sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2))))/(M_PI/180.0);
    // Dont care about the y coords
    GLfloat length = sqrt((x1-x2)*(x1-x2)+(z1-z2)*(z1-z2));
    GLfloat s_lp = y3-y1; // Start lowest point. (highest at 0,0,0)
    GLfloat e_lp = y4-y1; // End lowest point.
    GLfloat e_hp = y2-y1; // End highest point.


    // If debug mode.
    if (debug) {
      printf("Alpha: %f\n", alpha); 
      printf("s_lp: %f\ne_lp: %f\ne_hp: %f\n", s_lp, e_lp, e_hp);
      printf("Width: %f\n", width);
    }

    glNewList(l, GL_COMPILE);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
      glPushMatrix();
        glColor3f(1,1,1);
	// Reference lines, only if debug mode.
        if (debug || 1) {
	  glBegin(GL_LINES);
	    glColor3f(1.0, 0.0, 0.0);
	    glVertex3f(x1, y1-.01, z1);
	    glVertex3f(x2, y2-.01, z2);
	    glVertex3f(x3, y3-.01, z3);
	    glVertex3f(x4, y4-.01, z4);
	  glEnd();
	}
	glTranslatef(x1, y1, z1);
	glRotatef(180.0-alpha, 0.0, 1.0, 0.0);
	glBegin(GL_QUADS);
	  // Top
	glColor3f(1, 0, 0);
	  glVertex3f(0, 0, 0+width/2);
	  glVertex3f(0, 0, 0-width/2);
	  glVertex3f(length, e_hp, 0-width/2);
	  glVertex3f(length, e_hp, 0+width/2);
	  // Bottom
	  glColor3f(1, 1, 0);
	  glVertex3f(0, s_lp, 0-width/2);
	  glVertex3f(0, s_lp, 0+width/2);
	  glVertex3f(length, e_lp, 0+width/2);
	  glVertex3f(length, e_lp, 0-width/2);
	glEnd();
	glBegin(GL_QUAD_STRIP);
	  // Sides of the cube.
	glColor3f(0, 0, 1);
 	  glVertex3f(0, 0, 0+width/2);
	  glVertex3f(0, s_lp, 0+width/2);

	  glColor3f(0, 1, 0);
	  glVertex3f(0, 0, 0-width/2);
	  glVertex3f(0, s_lp, 0-width/2);

	  glColor3f(0, 0, 1);
  	  glVertex3f(length, e_hp, 0-width/2);
	  glVertex3f(length, e_lp, 0-width/2);

	  glColor3f(0, 1, 0);
	  glVertex3f(length, e_hp, 0+width/2);
	  glVertex3f(length, e_lp, 0+width/2);

	  glColor3f(0, 0, 1);
 	  glVertex3f(0, 0, 0+width/2);
	  glVertex3f(0, s_lp, 0+width/2);

	glEnd();
      glPopMatrix();
    glEndList();
    m_objects.push_back(l);
  }


  /*
  void addCube(GLfloat x1, GLfloat y1, GLfloat z1, GLfloat x2, GLfloat y2, GLfloat z2,
	       GLfloat x3, GLfloat y3, GLfloat z3, GLfloat x4, GLfloat y4, GLfloat z4, GLfloat d) {
    GLuint l = glGenLists(1);
    // Angle between upper line and x-axis.
    double alpha = (acos((z1-z2)/sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2))))/(M_PI/180.0);
    printf("Alpha: %f\n", alpha);
    GLfloat width = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    printf("Width: %f\n", width);
    glNewList(l, GL_COMPILE);
      glPushMatrix();
        glTranslatef(x1, y1, z1);
	// Reference lines.
	glBegin(GL_LINES);
	  glColor3f(1.0, 0.0, 0.0);
	  glVertex3f(x1, y1, z1);
	  glVertex3f(x2, y2, z2);
	  glVertex3f(x3, y3, z3);
	  glVertex3f(x4, y4, z4);
	glEnd();
        glRotatef(alpha, 0.0, 1.0, 0.0);
	glBegin(GL_QUADS);
	  // Draw it on the x-axis...
	  glColor3f(1.0, 1.0, 1.0);
	  // Top.
	  glVertex3f(0, 0, 0-d/2);
	  glVertex3f(0, 0-(y1-y2), d/2);
	  glVertex3f(width, 0-(y1-y2), d/2);
	  glVertex3f(width, 0-(y1-y2), 0-d/2);
	  // Bottom
	  glVertex3f(0, 0-(y1-y3), 0-d/2);
	  glVertex3f(0, 0-(y1-y4), d/2);
	  glVertex3f(width, 0-(y1-y3), d/2);
	  glVertex3f(width, 0-(y1-y4), 0-d/2);
	glEnd();
	glBegin(GL_QUAD_STRIP);
	  // Sides.
	  glColor3f(1.0, 1.0, 0.0);
	  glVertex3f(0, 0, 0-d/2);
	  glVertex3f(0, 0-(y1-y3), 0-d/2);
	  glVertex3f(0, 0-(y1-y2), d/2);
	  glVertex3f(0, 0-(y1-y4), d/2);

	  glColor3f(1.0, 0.0, 0.0);
	  glVertex3f(width, 0-(y1-y2), 0-d/2);
	  glVertex3f(width, 0-(y1-y4), 0-d/2);

	  glColor3f(0.0, 1.0, 0.0);
	  glVertex3f(width, 0-(y1-y2), d/2);
	  glVertex3f(width, 0-(y1-y3), d/2);

	  glColor3f(0.0, 0.0, 1.0);
	  glVertex3f(0, 0-(y1-y2), d/2);
	  glVertex3f(0, 0-(y1-y4), d/2);

	glEnd();
      glPopMatrix();
    glEndList();
    m_objects.push_back(l);
  }
  */

  /*
  void addCube(GLfloat x1, GLfloat y1, GLfloat z1, GLfloat x2, GLfloat y2, GLfloat z2) {
    GLuint l = glGenLists(1);
    glNewList(l, GL_COMPILE);
      glPushMatrix(); 
	glBegin(GL_QUADS);
	glColor3f(1.0, 1.0, 1.0);
	// Top.
	glVertex3f(x1, y1, z1);
	glVertex3f(x1, y1, z2);
	glVertex3f(x2, y1, z2);
	glVertex3f(x2, y1, z1);
	// Bottom.
	glVertex3f(x1, y2, z1);
	glVertex3f(x1, y2, z2);
	glVertex3f(x2, y2, z2);
	glVertex3f(x2, y2, z1);
	// Front.
	glVertex3f(x1, y1, z1);
	glVertex3f(x2, y1, z1);
	glVertex3f(x2, y2, z1);
	glVertex3f(x1, y2, z1);
	// Back.
	glVertex3f(x1, y1, z2);
	glVertex3f(x2, y1, z2);
	glVertex3f(x2, y2, z2);
	glVertex3f(x1, y2, z2);
	// Left.
	glVertex3f(x1, y1, z1);
	glVertex3f(x1, y2, z1);
	glVertex3f(x1, y2, z2);
	glVertex3f(x1, y1, z2);
	// Right.
	glVertex3f(x2, y1, z1);
	glVertex3f(x2, y2, z1);
	glVertex3f(x2, y2, z2);
	glVertex3f(x2, y1, z2);
	glEnd();
      glPopMatrix();
    glEndList();
    m_objects.push_back(l);
  }
  */


  /*
   * Draw all the objects in the container.
   */
  void draw() {
    for (std::vector<GLuint>::iterator itr = m_objects.begin(); itr != m_objects.end(); ++itr) {
      glCallList(*itr);
      GLError::get_instance().print();
    }
  }

  /*
   * Print the list, for debugging!
   */
  void printList() {
    printf("ShapeCont::print(), list is: ");
    for (std::vector<GLuint>::iterator itr = m_objects.begin(); itr != m_objects.end(); ++itr)
      printf("%d ", *itr);
    printf("\n");
  }
};


#endif
