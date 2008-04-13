#include <stdio.h>
#include <math.h>

struct vector {
  float x, y;
};

int main() {
  struct vector midp = {0, 0}; // The midpoint
  struct vector p1 = {1, 0}; // Point 1
  struct vector p2 = {-1, -1}; // Point 2
  
  struct vector v1 = {p1.x-midp.x, p1.y-midp.y}; // Vector midpoint to Point 1
  struct vector v2 = {p2.x-midp.x, p2.y-midp.y}; // Vector midpoint to Point 2

  double length1 = sqrt(p1.x*p1.x+p1.y*p1.y);
  float alpha1 = acos(p1.x/length1);
  double length2 = sqrt(p2.x*p2.x+p2.y*p2.y);
  float alpha2 = acos(p2.x/length2);

  alpha1 = alpha1 * 180/M_PI; // To degrees
  alpha2 = alpha2 * 180/M_PI; // To degrees
  

  printf("Angle between\nv1(%.2f, %.2f) and\nv2(%.2f, %.2f) is:\n%.4f\n",
	 v1.x, v1.y, v2.x, v2.y, alpha2-alpha1);
  return 0;
}
