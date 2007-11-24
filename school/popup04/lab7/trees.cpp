#include <vector>
#include <cstdio>
#include <cassert>
#include <cmath>

using namespace std;

inline long long int labs(long long int x) {
  return (x < 0) ? -x : x;
}

struct Point{
  long long int x, y;
  Point(long long int _x, long long int _y) : x(_x), y(_y) {}
  Point() {}
};

typedef vector<Point> poly_t;   
                                
static double area(const poly_t &poly) {
  if (poly.size() < 3) {        
    return 0;                   
  }                             
                                
  double a = 0.;                
  const unsigned int size = poly.size();
  for (unsigned int i = 0; i < size-1; ++i)
    a += poly[i].x*poly[i+1].y - poly[i+1].x*poly[i].y;
  a += poly[size-1].x*poly[0].y - poly[0].x*poly[size-1].y;
  return a * 0.5;               
}                               
                                
static int gcd(int p, int q) {  
  if (q == 0)                   
    return p;                   
  else                          
    return gcd(q, p % q);       
}                               
                                
static int on_edge(const poly_t &poly) {
  int n = 0;                    
  const unsigned int size = poly.size();
  for (unsigned int i = 0; i < size-1; ++i)
    n += gcd(labs(poly[i].x - poly[i+1].x), labs(poly[i].y - poly[i+1].y));
  n += gcd(labs(poly[0].x - poly[size-1].x), labs(poly[0].y-poly[size-1].y));
  return n;                     
}                               
                                
                                
int main() {                    
  int n_p;                      
  poly_t p;                     
                                
  while(scanf("%d", &n_p) && n_p) {
    for (int i = 0; i < n_p; ++i) {
      int x, y;                 
      scanf("%d %d", &x, &y);   
      p.push_back(Point(x, y)); 
    }                           
                                
    double A = fabs(area(p));   
    double R = (double)on_edge(p);
                                
#ifdef DBG                      
    printf("Area: \t\t%f\nOn edge: \t%f\n", A, R);
#endif                          

    if (A == 0.)
      printf("0\n");
    else {
      printf("%.0f\n", A - R/2 + 1);
    }
    p.clear();
  }
  
  return 0;
}
