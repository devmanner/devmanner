#include <list>
#include <cmath>
#include <cstdio>
#include <cassert>

//using namespace std;

typedef std::list<std::pair<float, float> > graph_t;

inline float cost(const std::pair<float, float> &p1, const std::pair<float, float> &p2) {
  return sqrt( (p1.first-p2.first)*(p1.first-p2.first) +
	       (p1.second-p2.second)*(p1.second-p2.second) );
}

int main() {
  int n_tc;
  scanf("%d", &n_tc);
  while (n_tc--) {
    int n_nodes;
    float x, y;
    graph_t nodes, merged;
    
    scanf("%d", &n_nodes);
    
    for (int i = 0; i < n_nodes-1; ++i) {
      scanf("%f%f", &x, &y);
      nodes.push_back(graph_t::value_type(x, y));
    }
    scanf("%f%f", &x, &y);
    merged.push_back(graph_t::value_type(x, y));
        
    
    /* Sätt ut |V|-1 kanter */
    float tot_dist = 0;
    for (int i = 1; i < n_nodes; ++i) {
      float min_dist = 99999999.0;
      graph_t::iterator min_elem = nodes.end();
      /* Finn den billigaste kanten att lägga till. */
      for (graph_t::iterator mitr = merged.begin(); mitr != merged.end(); ++mitr) {
	for (graph_t::iterator nitr = nodes.begin(); nitr != nodes.end(); ++nitr) {
	  float dist = cost(*mitr, *nitr);
	  if (dist < min_dist) {
	    min_elem = nitr;
	    min_dist = dist;
	  }
	}
      }
      assert(min_elem != nodes.end());
      /* Flytta minelementet till merged. */
      tot_dist += min_dist;
      merged.push_back(*min_elem);
      nodes.erase(min_elem);
    }
    printf("%.2f\n", tot_dist);
  }
}
