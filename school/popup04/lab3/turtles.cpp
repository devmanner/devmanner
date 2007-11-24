#include <algorithm>
#include <vector>
#include <iterator>
#include <iostream>
#include <cstdio>

using namespace std;

class Turtle {
public:
  Turtle(const Turtle &t) : weight(t.weight), cap(t.cap) { }
  Turtle(int w, int c) : weight(w), cap(c) { }
  int weight;
  int cap;
};


class TurtleRestCapSorter {
public:
  bool operator()(const Turtle &t1, const Turtle &t2) {
    return (t1.cap-t1.weight > t2.cap-t2.weight);
  }
};

int main() {
  int weight, cap;
  vector<Turtle> turtles;
  while (scanf("%d %d", &weight, &cap) != EOF)
    if (cap >= weight)
      turtles.push_back(Turtle(weight, cap));

  TurtleRestCapSorter turtleSorter;
  sort(turtles.begin(), turtles.end(), turtleSorter);

  for (vector<Turtle>::iterator itr = turtles.begin(); itr != turtles.end(); ++itr)
    printf("%d\t%d\t%d\n", itr->weight, itr->cap, itr->cap-itr->weight);


  /*
    height[i] = Maxhöjden på högen om sista sköldpaddan har index i i den sorterade listan.
  */
  int n_turtles = turtles.size();
  int *height = (int*)malloc(sizeof(int) * n_turtles);
  for (int i = 0; i < n_turtles; ++i)
    height[i] = 1;

  for (int i = 0; i < n_turtles; ++i) {

  }
  
  free(height);
  return 0;
}
