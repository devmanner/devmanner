#include <vector>
#include <set>
#include <algorithm>
#include <iostream>
#include <iterator>

#include <cstdio>
#include <cmath>
#include <cassert>

template <typename T>
void dump(const T &c, const char *s="\n") {
  std::copy(c.begin(), c.end(), std::ostream_iterator<typename T::value_type>(std::cout, s));
}

struct Point {
  int x, y;
  Point() {}

  Point(int _x, int _y) : x(_x), y(_y) {}
  void print(const char *s="") const {
    printf("%s[%d, %d]\n", s, x, y);
  }

  bool operator==(const Point &p) const {
    return p.x == x && p.y == y;
  }
  bool operator!=(const Point &p) const {
    return !(*this == p);
  }
  std::ostream& operator<<(std::ostream &os) const {
    static char buff[30];
    sprintf(buff, "[%d, %d]", x, y);
    os << buff;
    return os;
  }
};

std::ostream& operator<<(std::ostream &os, const Point &p) {
  return p << os;
}

typedef std::vector<Point> vec_t;

/* Constants */
const Point e1(1, 0);

#define MAX_POINTS 1000
const int UNDEF = 9999999;

#ifndef M_PI
#define M_PI 3.1415
#endif

#define rad_to_deg(x) (x * 180/M_PI)

template<typename T>
inline T pow2(const T &x) {
  return x*x;
}

inline double dist(const Point &p1, const Point &p2) {
  return sqrt(pow2(p1.x - p2.x) + pow2(p1.y - p2.y));
}

inline double len(const Point &p) {
  return sqrt(pow2(p.x)+pow2(p.y));
}

inline double cross(const Point &p1, const Point &p2) {
  return p1.x*p2.y + p1.y*p2.x;
}

/* Is p1 a _negative_ linear combination of p2? */
/*
int are_neg_linc(const Point &p1, const Point &p2) {
  double lp1 = len(p1);
  double lp2 = len(p2);
  if ( p1.x / lp1 + p2.x / lp2 < 0.00001 &&
       p1.y / lp1 + p2.y / lp2 < 0.00001 )
    return 1;
  return 0;
}
*/

/*
  Get quadrant of p
  2 | 1
----|---
  4 | 3
  0 = p is on an axis.
*/
int quadrant(const Point &p) {
  if (p.x < 0 && p.y > 0)
    return 2;
  else if (p.x > 0 && p.y > 0)
    return 1;
  else if (p.x < 0 && p.y < 0)
    return 4;
  else if (p.x > 0 && p.y < 0)
    return 3;
  return 0;
}

double angle(const Point &p1, const Point &p2) {
  Point vec(p2.x - p1.x, p2.y - p1.y);
  Point e;
  double ang;
  switch (quadrant(vec)) {
  case 1:
    ang = 0;
    e.x = 1;
    e.y = 0;
    break;
  case 2:
    ang = 90;
    e.x = 0;
    e.y = 1;
    break;
  case 3:
    ang = 270;
    e.x = 0;
    e.y = -1;
    break;
  case 4:
    ang = 180;
    e.x = -1;
    e.y = 0;
    break;
  default:
    if (vec.x > 0 && vec.y == 0)
      return 0.;
    else if (vec.x == 0 && vec.y > 0)
      return 90.;
    else if (vec.x < 0 && vec.y == 0)
      return 180.;
    else if (vec.x == 0 && vec.y < 0)
      return 270.;
    else if (vec.x == 0 && vec.y == 0)
      return 0;
    //    assert(0 && "vec == [0, 0] !!!");
    //assert(0 && "This better not happen...");
    break;
  }
  
  ang += rad_to_deg(fabs(asin(cross(e, vec)/len(vec))));
  return ang;
}

int area(const Point &p1, const Point &p2, const Point &p3) {
  int m11 = p1.x-p2.x, m12 = p1.y-p2.y;
  int m21 = p3.x-p1.x, m22 = p3.y-p1.y;
  return (m11*m22 - m12*m21);
}

class PointAngleSorter {
private:
  Point point;
public:
  PointAngleSorter(const Point p) : point(p) { }
  bool operator()(const Point &p1, const Point &p2) {
    if (angle(point, p1) == angle(point, p2))
      return dist(point, p1) > dist(point, p1);
    return angle(point, p1) > angle(point, p2);
  }
};

/* p shall not contain min! */
void convex_hull(vec_t &points, vec_t &result) {
  if (points.size() < 3) {
    /* No valid hull. */
    result.push_back(Point(UNDEF, UNDEF));
    result.push_back(Point(UNDEF, UNDEF));
    return;
  }

#ifdef DBG
  printf("points: ");
  dump(points);
#endif

  /* Get the min element. */
  Point min = *points.begin();
  for (vec_t::iterator itr = points.begin(); itr != points.end(); ++itr)
    if ( (itr->y < min.y) || (itr->y == min.y && itr->x < min.x) )
      min = *itr;

#ifdef DBG
  min.print("min:");
#endif

  /* Create the angle-sorted "set". */
  PointAngleSorter sorter(min);
  vec_t s;
  for (vec_t::iterator itr = points.begin(); itr != points.end(); ++itr) {
    /* If *itr is not in container nor == min. */
    if (std::find(s.begin(), s.end(), *itr) == s.end() && *itr != min)
      s.push_back(*itr);
  }

  std::sort(s.begin(), s.end(), sorter);

#ifdef DBG  
  printf("s: ");
  dump(s);
  printf("\n");
#endif

  /* < 2 since one in min. */
  if (s.size() < 2) {
    /* No valid hull. */
    result.push_back(Point(UNDEF, UNDEF));
    result.push_back(Point(UNDEF, UNDEF));
    return;
  }

  /* Add the two first points to the result. */
  result.push_back(min);
  result.push_back(s.back());
  s.pop_back();
  
  Point tmp;
  while (!s.empty() && tmp != min) {
    tmp = s.back();
    s.pop_back();

    /* While right turn. */
    while (area(result[result.size()-2], result[result.size()-1], tmp) >= 0) {
      if (s.empty()) {
	/* No valid hull. */
	result.clear();
	result.push_back(Point(UNDEF, UNDEF));
	result.push_back(Point(UNDEF, UNDEF));
	return;
      }
      tmp = s.back(); 
      s.pop_back();
      /*
	result.pop_back();*/
      assert(result.size() >= 2);
    }
    result.push_back(tmp);
  }
  result.push_back(min);
}

bool inside(const Point &point, const vec_t &poly) {
  vec_t::const_iterator fitr = poly.begin();
  ++fitr;
  if (poly.begin()->x == poly.begin()->y && poly.begin()->x == UNDEF)
    return false;

  for (vec_t::const_iterator bitr = poly.begin(); fitr != poly.end(); ++fitr, ++bitr)
    if (area(*bitr, *fitr, point) > 0)
      return false;
  return true;
}


int main() {
  int n_tc=1;
  int c, r, o;
  vec_t cops;
  vec_t cops_hull;
  vec_t robbers;
  vec_t robbers_hull;

  while (scanf("%d %d %d", &c, &r, &o) == 3 && (c || r || o)) {
    Point tmp;

    for (int i = 0; i < c; ++i) {
      scanf("%d %d", &(tmp.x), &(tmp.y));
      cops.push_back(tmp);
    }
    convex_hull(cops, cops_hull);

#ifdef DBG
    printf("Cops hull: ");
    dump(cops_hull);
#endif


    for (int i = 0; i < r; ++i) {
      scanf("%d %d", &(tmp.x), &(tmp.y));
      robbers.push_back(tmp);
    }
    convex_hull(robbers, robbers_hull);

#ifdef DBG
    printf("Robbers hull: ");
    dump(robbers_hull);
#endif
        
    printf("Data set %d:\n", n_tc++);
    for (int i = 0; i < o; ++i) {
      scanf("%d %d", &(tmp.x), &(tmp.y));
      if (inside(tmp, cops_hull) && cops_hull.size() > 3)
	printf("     Citizen at (%d,%d) is safe.\n", tmp.x, tmp.y);
      else if (inside(tmp, robbers_hull) && robbers_hull.size() > 3)
	printf("     Citizen at (%d,%d) is robbed.\n", tmp.x, tmp.y);
      else
	printf("     Citizen at (%d,%d) is neither.\n", tmp.x, tmp.y);
    }
    printf("\n");

    cops.clear();
    cops_hull.clear();
    robbers.clear();
    robbers_hull.clear();

  }
  return 0;
}
