#include "shape.h"

Shape::Shape(float *color, bool isPiece) : m_isPiece(isPiece) {
	transformation tmp = {{0.f,0.f,0.f},{1.f,0.f,0.f,0.f}, {.05f,.05f,.05f}};
	m_tra = tmp;
	memcpy(m_color, color, sizeof(m_color));
}

Shape::Shape(float *translation, float *rotation, float *scale, float *color, bool isPiece) {
	memcpy(m_tra.translation, translation, sizeof(m_tra.translation));
	memcpy(m_tra.rotation, rotation, sizeof(m_tra.rotation));
	memcpy(m_tra.scale, scale, sizeof(m_tra.scale));
	memcpy(m_color, color, sizeof(m_color));
	m_isPiece = isPiece;
	#ifdef _DEBUG_MODE_
		printf("ShapeConstructor:: makes a lot of memcpy");
	#endif
}

Shape::~Shape(){
}

void Shape::draw() {
	glCallList(m_list);
}

transformation* Shape::getTrans(){
	return &m_tra;
}

float * Shape::getColor(){
	return m_color;
}

bool Shape::isPiece() {
	return m_isPiece;
}

/*--------------------------------------------------------------------------------
 StraightBox
--------------------------------------------------------------------------------*/

StraightBox::StraightBox(Vertex min, Vertex max, float *c, bool isPiece):
  Box(c, isPiece), m_min(min), m_max(max), m_zOffset(0) {
  if (isPiece)
    m_zOffset = SMALL_DBL;
}

void StraightBox::create() {
#ifdef _DEBUG_MODE_
  printf("skapar straightbox\n");
  m_min.print();
  m_max.print();
  printf("\n");
#endif
  m_list = glGenLists(1);
  glNewList(m_list, GL_COMPILE);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, m_color);
  glPushMatrix();
  glBegin(GL_QUADS);
  // Top
  glColor3f(0.5,0.5,1);
  glVertex3f(m_max.m_x,	m_max.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_max.m_x,	m_max.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_min.m_x,	m_max.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_min.m_x,	m_max.m_y, m_max.m_z - m_zOffset);
  
  // Bottom
  glVertex3f(m_min.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_min.m_x,	m_min.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_max.m_x,	m_min.m_y, m_min.m_z + m_zOffset);				
  glVertex3f(m_max.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  
  //Front Side
  glVertex3f(m_max.m_x,	m_max.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_min.m_x,	m_max.m_y, m_max.m_z - m_zOffset);				
  glVertex3f(m_min.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_max.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  
  //Left Side
  glVertex3f(m_min.m_x,	m_max.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_min.m_x,	m_max.m_y, m_min.m_z + m_zOffset);				
  glVertex3f(m_min.m_x,	m_min.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_min.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  
  //Rear Side
  glVertex3f(m_min.m_x,	m_max.m_y, m_min.m_z + m_zOffset);				
  glVertex3f(m_max.m_x,	m_max.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_max.m_x,	m_min.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_min.m_x,	m_min.m_y, m_min.m_z + m_zOffset);
  
  //Right Side
  glVertex3f(m_max.m_x,	m_max.m_y, m_min.m_z + m_zOffset);
  glVertex3f(m_max.m_x,	m_max.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_max.m_x,	m_min.m_y, m_max.m_z - m_zOffset);
  glVertex3f(m_max.m_x,	m_min.m_y, m_min.m_z + m_zOffset);
  glEnd();
  
  glPopMatrix();
  glEndList();
  
}


/*--------------------------------------------------------------------------------
 GayBox
--------------------------------------------------------------------------------*/
GayBox::GayBox(Vertex b1, Vertex b2,double width, int alignment, float *c, bool isPiece) 
  : Shape(c, isPiece), m_back1(b1), m_back2(b2), m_width(width), m_alignment(alignment), m_zoffset(0) {
  Vertex sub = Vertex(m_back2.m_x - m_back1.m_x, m_back2.m_y - m_back1.m_y, m_back2.m_z - m_back1.m_z);
  m_length = sqrt(sub.m_x*sub.m_x + sub.m_y*sub.m_y);
  m_alpha = toDeg(acos(sub.m_x / m_length));
  // We always want a positive counter clockwise angle.
  if (sub.m_y < 0)
    m_alpha = 360.0 - m_alpha;
  
  if(m_back2.m_z > 0)
    m_zoffset -= m_back2.m_z;
  if(m_back1.m_z > 0)
    m_zoffset -= m_back1.m_z;
}

void GayBox::create(){
  m_list = glGenLists(1);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, m_color);
  glNewList(m_list, GL_COMPILE);
  glPushMatrix();
#ifdef _DEBUG_MODE_
  glPushMatrix();
    glBegin(GL_LINES);
    glColor3f(1.,0.,0.);
    m_back1.draw();
    m_back2.draw();
    glEnd();
    glPopMatrix();
#endif
  glTranslatef(m_back1.m_x, m_back1.m_y, -m_zoffset);
  glRotatef(m_alpha, 0, 0, 1);
  glPushMatrix();
  glBegin(GL_QUADS);
  // Bottom
  ColorSetter::getInstance().setColor(m_back1.m_z);
  glVertex3f(0, 0-m_width/2, m_back1.m_z + m_zoffset);
  glVertex3f(0, m_width/2, m_back1.m_z + m_zoffset);
  ColorSetter::getInstance().setColor(m_back2.m_z);
  glVertex3f(m_length, m_width/2, m_back2.m_z + m_zoffset);
  glVertex3f(m_length, 0-m_width/2, m_back2.m_z + m_zoffset);
  // Top
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(0, m_width/2, 0);
  glVertex3f(0, 0-m_width/2, 0);
  glVertex3f(m_length, 0-m_width/2, 0);
  glVertex3f(m_length, m_width/2, 0);
  
  glEnd();
  
  // Sides
  glBegin(GL_QUAD_STRIP);
  //glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, inner);
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(0, m_width/2, 0);	
  ColorSetter::getInstance().setColor(m_back1.m_z);
  glVertex3f(0, m_width/2, m_back1.m_z + m_zoffset);
  
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(0, 0-m_width/2, 0);
  ColorSetter::getInstance().setColor(m_back1.m_z);
  glVertex3f(0, 0-m_width/2, m_back1.m_z + m_zoffset);
  
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(m_length, 0-m_width/2, 0);
  ColorSetter::getInstance().setColor(m_back2.m_z);
  glVertex3f(m_length, 0-m_width/2, m_back2.m_z + m_zoffset);
  
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(m_length, m_width/2, 0);
  ColorSetter::getInstance().setColor(m_back2.m_z);
  glVertex3f(m_length, m_width/2, m_back2.m_z + m_zoffset);
  
  ColorSetter::getInstance().setColor(-m_zoffset);
  glVertex3f(0, m_width/2, 0);
  ColorSetter::getInstance().setColor(m_back1.m_z);
  glVertex3f(0, m_width/2, m_back1.m_z + m_zoffset);
  
  glEnd();
  glPopMatrix();
  glPopMatrix();
  glEndList();
}

void GayBox::print(){
#ifdef _DEBUG_MODE_
  printf("----------------------------\n");
  m_back1.print();
  m_back2.print();
  printf("Width: %.2f\nAlpha: %.2f\nLength: %.2f\nZoffset: %.2f\n", m_width, m_alpha, m_length, m_zoffset);
  printf("----------------------------\n");
#endif
}


/*--------------------------------------------------------------------------------
 Cylinder
--------------------------------------------------------------------------------*/

Cylinder::Cylinder(Vertex bottomCenter, GLfloat d, GLfloat h, GLfloat *c, bool isPiece) :
  Quadric(c, isPiece), m_bottomCenter(bottomCenter), m_d(d), m_h(h) { 
  static int cnt = 0;
#ifdef _DEBUG_MODE_
  printf("Skapar Cyliner %d\n", cnt++);
  m_bottomCenter.print();
  printf("med höjd: %.2f\n", m_h);
#endif
}

void Cylinder::create() {
  m_list = glGenLists(1);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, m_color);
  glNewList(m_list, GL_COMPILE);
  glPushMatrix();
  glTranslatef(m_bottomCenter.m_x,m_bottomCenter.m_y,m_bottomCenter.m_z);
  glPushMatrix();
  glBegin(GL_QUAD_STRIP);
  for(int i=0 ; i <= 360 ; i += 12){
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
    glVertex3f(CosSinTable::getInstance().sin(i)*m_d,CosSinTable::getInstance().cos(i)*m_d,0);
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_h);
    glVertex3f(CosSinTable::getInstance().sin(i)*m_d,CosSinTable::getInstance().cos(i)*m_d, m_h);
  }
  glEnd();
  glPopMatrix();
  glPushMatrix();
  // Bottom
  glRotatef(180, 1, 0, 0);	
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  gluDisk(m_quadric, 0., m_d, 30, 2);
  glPopMatrix();
  glPushMatrix();
  // Top
  glTranslatef(0,0,m_h);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_h);
  gluDisk(m_quadric, 0., m_d, 30, 2);
  glPopMatrix();
  glPopMatrix();
  glEndList();
}

/*--------------------------------------------------------------------------------
 Cone
--------------------------------------------------------------------------------*/

void Cone::create() {
  m_list = glGenLists(1);
  glNewList(m_list, GL_COMPILE);
  glPushMatrix();
  glTranslatef(0, 0, -.5);
  gluCylinder(m_quadric, 1, 0, 1, 30, 5);
  glRotatef(180, 0, 1, 0);
  gluDisk(m_quadric, 0, 1, 30, 2);
  glPopMatrix();
  glEndList();
}

/*--------------------------------------------------------------------------------
 Sphere
--------------------------------------------------------------------------------*/
void Sphere::create() {
  m_list = glGenLists(1);
  glNewList(m_list, GL_COMPILE);
  gluSphere(m_quadric, 1, 30, 20);
  glEndList();
}

/*--------------------------------------------------------------------------------
 SolidArc
--------------------------------------------------------------------------------*/
SolidArc::SolidArc(Vertex bottomCenter, bool clockwise, GLdouble innerRadius, GLdouble outerRadius, GLdouble startAngle, GLdouble sweepAngle, GLfloat height, float *c, bool isPiece)
  : Quadric(c, isPiece), m_bottomCenter(bottomCenter), m_clockwise(clockwise), m_innerRadius(innerRadius), 
  m_outerRadius(outerRadius), m_startAngle(startAngle + 270.), m_sweepAngle(sweepAngle), m_height(height) {
  m_quadric = gluNewQuadric();
}
void SolidArc::create() {
  float startAngleDeg	= m_startAngle*M_PI/180;
  float endAngleDeg		= (m_startAngle + m_sweepAngle)*M_PI/180;
  float xStartInner = sin(startAngleDeg)*m_innerRadius;
  float xStartOuter = sin(startAngleDeg)*m_outerRadius;
  float xEndInner		= sin(endAngleDeg)*m_innerRadius;
  float xEndOuter		= sin(endAngleDeg)*m_outerRadius;
  float yStartInner = cos(startAngleDeg)*m_innerRadius;
  float yStartOuter = cos(startAngleDeg)*m_outerRadius;
  float yEndInner		= cos(endAngleDeg)*m_innerRadius;
  float yEndOuter		= cos(endAngleDeg)*m_outerRadius;
  GLint loops = 1, slices;
  
#ifdef _DEBUG_MODE_
  printf("Creating arc at: ");
  m_bottomCenter.print();
#endif
  
  if(m_sweepAngle > 10)
    slices = (GLint) m_sweepAngle / 10; // 1 slice is 9 degrees.
  else
    slices = 10;
  
  m_list = glGenLists(1);
  glNewList(m_list, GL_COMPILE);
  glPushMatrix();
  glTranslatef(m_bottomCenter.m_x, m_bottomCenter.m_y, m_bottomCenter.m_z);
  if (!m_clockwise)
    glRotatef(m_sweepAngle, 0, 0, 1);
  glPushMatrix();
  glBegin(GL_QUADS);
  // Sides
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xStartInner,yStartInner,0);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
  glVertex3f(xStartInner,yStartInner,m_height);
  glVertex3f(xStartOuter,yStartOuter,m_height);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xStartOuter,yStartOuter,0);
  
  glVertex3f(xEndOuter,yEndOuter,0);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
  glVertex3f(xEndOuter,yEndOuter,m_height);
  glVertex3f(xEndInner,yEndInner,m_height);
  
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xEndInner,yEndInner,0);
  glEnd();
  glPopMatrix();
  glPushMatrix();
  glBegin(GL_QUAD_STRIP);
  // Inner side
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
  glVertex3f(xEndInner,yEndInner,m_height);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xEndInner,yEndInner,0);			
  
  for(int i=(GLint)(m_startAngle+m_sweepAngle) ; i >= m_startAngle ; i -= (GLint)(m_sweepAngle)/slices){ 
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
    glVertex3f(CosSinTable::getInstance().sin(i)*m_innerRadius,CosSinTable::getInstance().cos(i)*m_innerRadius,0);
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);     
    glVertex3f(CosSinTable::getInstance().sin(i)*m_innerRadius,CosSinTable::getInstance().cos(i)*m_innerRadius,m_height);
  }

  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);     
  glVertex3f(xStartInner,yStartInner,0);

  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);     
  glVertex3f(xStartInner,yStartInner,m_height);
  glEnd();
  glPopMatrix();
  
  glPushMatrix();
  glBegin(GL_QUAD_STRIP);
  // Outer side
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);     
  glVertex3f(xStartOuter,yStartOuter,m_height);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xStartOuter,yStartOuter,0);
  for(int i = (GLint)m_startAngle; i <= ((m_startAngle + m_sweepAngle)); i += (GLint)((m_sweepAngle)/slices)){
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
    glVertex3f(CosSinTable::getInstance().sin(i)*m_outerRadius,CosSinTable::getInstance().cos(i)*m_outerRadius,0);
    ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
    glVertex3f(CosSinTable::getInstance().sin(i)*m_outerRadius,CosSinTable::getInstance().cos(i)*m_outerRadius,m_height);
  }
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glVertex3f(xEndOuter,yEndOuter,0);
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
  glVertex3f(xEndOuter,yEndOuter,m_height);
  glEnd();
  glPopMatrix();
  glPushMatrix();
  //Top
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z);
  glRotatef(180,0,1,0);
  gluPartialDisk(m_quadric, m_innerRadius, m_outerRadius,
		 slices, loops, 360-m_sweepAngle-m_startAngle, m_sweepAngle);
  glPopMatrix();
  glPushMatrix();
  //Bottom
  ColorSetter::getInstance().setColor(m_bottomCenter.m_z + m_height);
  glTranslatef(0.,0.,m_height);
  gluPartialDisk(m_quadric, m_innerRadius, m_outerRadius,
		 slices, loops, m_startAngle, m_sweepAngle);
  glPopMatrix();
  glPopMatrix();
  glEndList();
}

