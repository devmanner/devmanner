#include <iostream>
#include <limits>
#include <stdio.h>

using namespace std;

const double DBL_MAX = std::numeric_limits<double>::max();
const double UNDEFINED_VALUE = DBL_MAX;

struct Vertex{ 
	double m_x, m_y, m_z;
	Vertex(double x=UNDEFINED_VALUE, double y=UNDEFINED_VALUE, double z=UNDEFINED_VALUE) : m_x(x), m_y(y), m_z(z) { }
	void print(){
		cout << '[' << m_x << ',' << m_y << ',' << m_z << ']';
	}
};

struct Box {
  Vertex m_max, m_min;
  Box(Vertex max, Vertex min) : m_max(max), m_min(min) {}
  bool collisionTest(Vertex max, Vertex min) {
    return ( ((m_max.m_x < max.m_x && m_max.m_y < max.m_y && m_max.m_z < max.m_z) &&
	      (m_min.m_x > max.m_x && m_min.m_y > min.m_y && m_min.m_z > max.m_z)) ||
	     ((m_min.m_x < min.m_x && m_min.m_y < min.m_y && m_min.m_z < min.m_z) &&
	      (m_max.m_x > min.m_x && m_max.m_y > min.m_y && m_max.m_z > min.m_z)) );
  }
  bool collisionTest(Box &b) {
    return collisionTest(b.m_max, b.m_min);
  }

};


int main() {
  Box b1(Vertex(1, 1, 1), Vertex(-1, -1, -1));
  Box b2(Vertex(2, 2, 2), Vertex(.5, .5, .5));

  cout << b1.collisionTest(b2) << endl << b2.collisionTest(b1) << endl;

}

