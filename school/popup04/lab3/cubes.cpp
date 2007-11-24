#include <vector>
#include <algorithm>
#include <iterator>
#include <iostream>

#include <cstdio>

using namespace std;

struct Cube {
  int weight;
  union {
    int colours[6];
    struct {
      int front, back, left, right, top, bottom;
    };
  };
};


enum side {front, back, left, right, top, bottom, cnt};
char *side_names[] = {"front", "back", "left", "right", "top", "bottom"};

void printCubes(Cube* c, int n) {
  printf("weight:\tfront\tback\tleft\tright\ttop\tbottom\n");
  for (int i = 0; i < n; ++i)
    printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
	   c[i].weight, c[i].front, c[i].back, c[i].left,
	   c[i].right, c[i].top, c[i].bottom);
}

#define MAX 500


int main() {
  int colour[MAX][MAX];
  int height[MAX];
  int prev[MAX];

  int n_cubes, ntc = 1;
  Cube *cubes;

  while (scanf("%d", &n_cubes) != EOF) {
    if (!n_cubes)
      break;

    cubes = (Cube*) malloc(sizeof(Cube) * n_cubes);
    for (int i = 0; i < n_cubes; ++i) {
      scanf("%d %d %d %d %d %d", &cubes[i].front, &cubes[i].back,
	    &cubes[i].left, &cubes[i].right, &cubes[i].top, &cubes[i].bottom);
      cubes[i].weight = i;
    }
    
    printCubes(cubes, n_cubes);

    /*
      height[i] = Maximala höjden om den sista (nedersta) har vikt (id) i.
      colour[i] = tänkbara färger nedåt om den nedersta kuben är i och höjden
      är height[i].
    */
    
    for (int i = 0; i < MAX; ++i) {
      for (int j = 0; j < MAX; ++j)
	colour[i][j] = -1;
      prev[i] = height[i] = -1;
    }

    height[0] = 1;
    for (int i = 0; i < 6; ++i)
      colour[0][i] = cubes[0].colours[i];

    for (int i = 1; i < n_cubes; ++i) {
      for (int n = i; n > 0; --n) {
	int found_colours = 0;
	for (int *p = colour[i]; *p != -1; ++p) {
	  for (int j = 0; j < 6; ++j) {
	    if (*p == cubes[i].colours[j] && height[i] <= height[i-n]+1) {
	      colour[i][found_colours++] = *p;
	      height[i] = height[i-n] + 1;
	      prev[i] = i-n;
	    }
	  }
	}
      }
    }
    
    typedef vector<pair<int, enum side> > sol_t;
    sol_t sol;
    
    printf("prev: ");
    copy(prev, &prev[n_cubes], ostream_iterator<int>(cout, " "));
    printf("\n");
    
    int curr = prev[distance(height, max_element(height, &height[n_cubes]))];
    while (curr != -1) {
      enum side s;
      for (int i = 0; i < 6; ++i)
	if (colour[curr][0] == cubes[curr].colours[i])
	  s = (enum side) i;
      sol.push_back( sol_t::value_type(curr, s) );
      curr = prev[curr];
    }


    for (sol_t::iterator itr = sol.begin(); itr != sol.end(); ++itr)
      printf("%d %s\n", itr->first, side_names[itr->second]);

    free(cubes);
    ++ntc;
  }
  
}
