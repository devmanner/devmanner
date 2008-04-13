#ifndef _COLORSETTER_H_
#define _COLORSETTER_H_


#ifndef DBL_MAX
const double DBL_MAX = std::numeric_limits<double>::max();
#endif

const double SMALL_DBL = 0.01;
const double UNDEFINED_VALUE = DBL_MAX;

struct Vertex{ 
  double m_x, m_y, m_z;
  Vertex(double x=UNDEFINED_VALUE, double y=UNDEFINED_VALUE, double z=UNDEFINED_VALUE)
    : m_x(x), m_y(y), m_z(z) { }
  void print(){
    if(m_x == UNDEFINED_VALUE)
      printf("[U");
    else
      printf("[%.2f", m_x);
    if(m_y == UNDEFINED_VALUE)
      printf(",U,");
    else
      printf(",%.2f,", m_y);
    if(m_z == UNDEFINED_VALUE)
      printf("U]");
    else
      printf("%.2f]", m_z);
  }
  void draw(){
    glVertex3f(m_x, m_y, m_z);
  }
};


Vertex getMax() {
  return Vertex(0, 0, 1);
}

Vertex getMin() {
  return Vertex(0, 0, -1);
}

double absd(const double &d) {
  return (d < 0) ? -d : d;
}


class ColorSetter {
private:
  bool m_edgesDefined; // Are max and min defined yet?
  double m_maxz; // Maximum z-value, taken from CutterController.
  double m_minz; // Minimum z-value, taken from CutterController.
  double m_prevz; // The Previous z-value (used for optimization).
  void (ColorSetter::*m_colorFunc)(double); // The color function currently used.

  ColorSetter() :
    m_edgesDefined(false), m_maxz(UNDEFINED_VALUE), m_minz(UNDEFINED_VALUE), m_prevz(UNDEFINED_VALUE), m_colorFunc(&ColorSetter::setColor2) { }

  /*
   * setColor2() : Interpolate between red and blue.
   */
  void setColor2(double z) {
    static double r=0, b=0;
    // Optimization...
    if (z == m_prevz) {
      glColor3f(r, 0, b);
      return;
    }
    m_prevz = z;
    if (z > m_maxz) { // Red over piece
      r = 1; b = 0;
    }
    else if (z < m_minz) { // Blue below piece
      r = 0; b = 1;
    }
    else {
      b = (m_maxz-z)/(m_maxz-m_minz);
      r = 1 - b;
    }
    glColor3f(r, 0, b);
  }
  
  /*
   * setColor4() : Interpolate between red, yellow, green, cyan and blue.
   */
  void setColor4(double z) {
    static double r=0, g=0, b=0;

    // Optimization.
    if (z == m_prevz) {
      glColor3f(r, g, b);
      return;
    }
    m_prevz = z;

    if (z > m_maxz) { // Red over piece
      r = 1; g = 0; b = 0;
    }
    else if (z < m_minz) { // Blue below piece
      r = 0; b = 1; g = 0;
    }
    else {
      double offset = m_maxz - z; // Distance to maxz.
      static double stepsize = absd(m_maxz - m_minz) / 4; // Only calculated once.
      if (offset < stepsize) {
	r = 1;
	g = 1-absd(offset - stepsize) / stepsize;
	b = 0;
      }
      else if (offset < stepsize*2){
	r = absd(offset - stepsize*2) / stepsize;
	g = 1;
	b = 0;
      }
      else if (offset < stepsize*3){
	r = 0;
	g = 1;
	b = 1-absd(offset - stepsize*3) / stepsize;
      }
      else{
	r = 0;
	g = absd(offset - stepsize*4) / stepsize;
	b = 1;
      } 
    }
    glColor3f(r, g, b);
  }


public:
  static ColorSetter& getInstance() {
    static ColorSetter cs;
    if (!cs.m_edgesDefined) {
      cs.m_maxz = getMax().m_z;
      cs.m_minz = getMin().m_z;
      if (cs.m_maxz != UNDEFINED_VALUE && cs.m_maxz != UNDEFINED_VALUE)
	cs.m_edgesDefined = true;
    }
    return cs;
  }

  void toggleColorMode() {
    m_colorFunc = (m_colorFunc == (&ColorSetter::setColor2)) ? (&ColorSetter::setColor4) : (&ColorSetter::setColor2);
  }

  void setColor(double z) {
    (this->*m_colorFunc)(z);
  }
  inline void setColor(Vertex &v) {
    if (v.m_z != UNDEFINED_VALUE)
      setColor(v.m_z);
  }
  
};

#endif
