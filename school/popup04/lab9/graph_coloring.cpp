/* @JUDGE_ID: 49669RA 193 C++ "Graph Coloring" */ 

#include <vector>
#include <set>
#include <cstdio>
#include <cstdlib>
#include <cassert>

using namespace std;

enum color {BLACK, WHITE, NONE};

struct Node {
  Node() : color(NONE), neigh() {}
  enum color color;
  set<int> neigh;
};
typedef vector<Node> graph_t;

void print(const graph_t &graph) {
  for (size_t i = 1; i < graph.size(); ++i) {
    printf("%d ", i);
    if (graph[i].color == WHITE)
      printf("(white):\t");
    else if (graph[i].color == BLACK)
      printf("(black):\t");
    else
      printf("(none):\t");
    for (set<int>::iterator iitr = graph[i].neigh.begin(); iitr != graph[i].neigh.end(); ++iitr)
      printf("%d ", *iitr);
    printf("\n");
  }
}

void paint_neigh(graph_t &graph, int whos, enum color color) {
  for (set<int>::iterator itr = graph[whos].neigh.begin(); itr != graph[whos].neigh.end(); ++itr)
    graph[*itr].color = color;
}

int get_rand_node(const graph_t &graph) {
  static vector<int> cand;
  cand.clear();
  for (unsigned i = 1; i < graph.size(); ++i)
    if (graph[i].color == NONE)
      cand.push_back(i);
  if (cand.empty()) {
    return -1;
  }
  return cand[rand() % cand.size()];
}

void colour(graph_t &graph) {
  int rnd_times = 100;
  std::set<int> best;
  const size_t n_nodes = graph.size();
  
  while (rnd_times--) {
    int node;
    unsigned n_black = 0, n_white = 0;

    do {
      node = get_rand_node(graph);
      if (node == -1)
	break;
      graph[node].color = BLACK;
      ++n_black;
      paint_neigh(graph, node, WHITE);
      n_white += graph[node].neigh.size();
    } while (1);
    
    // Check if the blackpaint is the best.
    //    printf("\nnblack: %d, best.size() %d\n", n_black, best.size());
    //print(graph);

    if (n_black > best.size()) {
#ifdef DBG
      printf("Found a best of size: %d: ", best.size());
#endif
      best.clear();
      for (unsigned i = 1; i < graph.size(); ++i)
	if (graph[i].color == BLACK) {
	  best.insert(i);
#ifdef DBG
	  printf("%d ", i);
#endif
	}
#ifdef DBG
      printf("\n");
#endif
    }
    
    // Reaset the graph
    for (unsigned i = 1; i < graph.size(); ++i)
      graph[i].color = NONE;
  }
  printf("%d\n", best.size());
  for (set<int>::iterator itr = best.begin(); itr != best.end(); ++itr)
    printf("%d ", *itr);
  if (best.empty())
    printf("1");
  printf("\n");
}

int main() {
  int ntc;
  int n_nodes, n_edges;
  srand(time(NULL));

  scanf("%d", &ntc);
  while (ntc--) {
    scanf("%d %d", &n_nodes, &n_edges);
    graph_t graph(n_nodes+1);
    for (int i = 0; i < n_edges; ++i) {
      int from, to;
      scanf("%d %d", &from, &to);
      //assert(from != to);
      graph[from].neigh.insert(to);
      graph[to].neigh.insert(from);
    }
    colour(graph);
  }
  return 0;
}
