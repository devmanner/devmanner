#include "clock.h"

#include <GL/gl.h>
#include <math.h>

clock_c::clock_c(void)
{
	m_ulTime = 0;
	m_iBackground = glGenLists(1);
	glNewList(m_iBackground,GL_COMPILE);
		for(float a = 0;a < 360; a += 15)
		{
			glRotatef(15,0,0,1);
			glBegin(GL_TRIANGLES);
			glVertex3f(-0.02f,1,0);
			glVertex3f(0,0.98f,0);
			glVertex3f(0.002f,1,0);
			glEnd();
		}
	glEndList();
}

static const GLfloat RotSpeed = -360.0f / 1000.0f; 

void clock_c::draw(void)
{
	GLfloat pointer[][3] =
	{
		{0,1,0},
		{-0.05f,0,0},
		{0.05f,0,0}
	};
	glPushMatrix();

	glRotatef(m_ulTime * RotSpeed / 15,0,1,0);

	glPushMatrix();
	glCallList(m_iBackground);
	glPopMatrix();

	glPushMatrix();
	glRotatef(RotSpeed * m_ulTime,0,0,1);

	glBegin(GL_TRIANGLES);
		glVertex3fv(pointer[0]);
		glVertex3fv(pointer[1]);
		glVertex3fv(pointer[2]);
	glEnd();

	glPopMatrix();
	glRotatef(RotSpeed / 60.0f * m_ulTime,0,0,1);

	glBegin(GL_TRIANGLES);
		glVertex3fv(pointer[0]);
		glVertex3fv(pointer[1]);
		glVertex3fv(pointer[2]);

	glEnd();

	glPopMatrix();
}

void clock_c::update(unsigned long _ulMSec)
{
	m_ulTime += _ulMSec;
}
