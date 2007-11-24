#include <stdio.h>
#include <math.h>
#include <assert.h>

struct point {
  int x, y;
};

/* Constants */
const struct point e1 = {1, 0};


#define MAX_POINTS 1000
#define pow2(x) (x*x)
#define rad_to_deg(x) (x * 180/M_PI)

void print(const struct point *p) {
  printf("[%d, %d]\n", p->x, p->y);
}

double dist(const struct point *p1, const struct point *p2) {
  return sqrt(pow2(p1->x - p2->x) + pow2(p1->y - p2->y));
}

double len(const struct point *p) {
  return sqrt(pow2(p->x)+pow2(p->y));
}

double cross(const struct point *p1, const struct point *p2) {
  return p1->x*p2->y + p1->y*p2->x;
}

/* Is p1 a _negative_ linear combination of p2? */
int are_neg_linc(const struct point *p1, const struct point *p2) {
  double lp1 = len(p1);
  double lp2 = len(p2);
  if ( p1->x / lp1 + p2->x / lp2 < 0.00001 &&
       p1->y / lp1 + p2->y / lp2 < 0.00001 )
    return 1;
  return 0;
}


/*
  Get quadrant of p
  2 | 1
----|---
  4 | 3
  0 = p is on an axis.
*/
int quadrant(const struct point *p) {
  if (p->x < 0 && p->y > 0)
    return 2;
  else if (p->x > 0 && p->y > 0)
    return 1;
  else if (p->x < 0 && p->y < 0)
    return 4;
  else if (p->x > 0 && p->y < 0)
    return 3;
  return 0;
}

double angle(const struct point *p1, const struct point *p2) {
  struct point vec = {p2->x - p1->x, p2->y - p1->y};
  struct point e;
  double ang;
  switch (quadrant(&vec)) {
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
    assert(0 && "foobar!!");
    break;
  }
  
  ang += rad_to_deg(fabs(asin(cross(&e, &vec)/len(&vec))));
  
  return ang;
}

struct point points[MAX_POINTS+1];
struct point result[MAX_POINTS+1];



int main() {
  int ntc;
  scanf("%d", &ntc);
  while (ntc--) {
    int np;
    int i;
    scanf("%d", &np);
    for (int i = 1; i <= np; ++i)
      scanf("%d %d", &(points[i].y), &(points[i].x));
    
    /* Find the minimum angle from current point to another */
    /* Add that point and remove from points. */
    

  }
  return 0;
}

