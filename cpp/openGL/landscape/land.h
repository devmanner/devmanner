#ifndef _LAND_H_
#define _LAND_H_

class Land {
private:
  GLfloat m_alt[64][64];
  GLuint m_list;
  

  void setColor(GLfloat alt) {
    GLfloat maxy = 2.0;
    if (alt < 0) {
      glColor3f(0, 0, 0);
      return;
    }
    glColor3f(1-(alt/maxy), 0, alt/maxy);
  }

public:

  void makeLandscape() {
    m_list = glGenLists(1);
    glNewList(m_list, GL_COMPILE);
    glPushMatrix();
    glBegin(GL_TRIANGLES);
    
    for (int i = 0; i < 63; ++i) {
      for (int j = 0; j < 63; ++j) {
	m_alt[i][j] = (rand() % 100) / 100.0;


	/* 1:st triangle. */
	setColor(m_alt[i][j]);
	glVertex3f(i-32, m_alt[i][j], j-32);
	
	setColor(m_alt[i+1][j]);
	glVertex3f(i+1-32, m_alt[i+1][j], j-32);
	
	setColor(m_alt[i+1][j+1]);
	glVertex3f(i+1-32, m_alt[i+1][j+1], j+1-32);
	
	/* 2:nd triangle. */
	setColor(m_alt[i][j]);
	glVertex3f(i-32, m_alt[i][j], j-32);
	
	setColor(m_alt[i+1][j+1]);
	glVertex3f(i+1-32, m_alt[i+1][j+1], j+1-32);
	
	setColor(m_alt[i][j+1]);
	glVertex3f(i-32, m_alt[i][j+1], j+1-32);
      }
    }
    
    glEnd();
    glPopMatrix();
    glEndList(); 
  }

  Land() {
  }
  
  GLfloat getAlt(int i, int j) { return m_alt[i][j]; }
  void draw() { glCallList(m_list); }

};

#endif
