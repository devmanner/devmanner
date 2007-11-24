#include <map>
#include <queue>
#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <string>

using namespace std;

// C includes.
#include <cassert>
#include <cstdio>

inline double pow2(double d) { return d*d; }

enum Color_t{
  WHITE, BLACK
};

struct Node_t {
  typedef size_t key_t;
  struct value_t{
    int m_capacity;
    int m_restCap;
    int m_flow;
    value_t(int v=0) : m_capacity(v), m_restCap(v), m_flow(0){}
  };
  typedef std::map<key_t, value_t>	neighbour_t;
  typedef neighbour_t::const_iterator   c_nItr;
  typedef neighbour_t::iterator		nItr;
  typedef neighbour_t::value_type	n_vtype;
  
  neighbour_t m_neighbours;
  key_t	      m_parent;
  Color_t     m_status;	
  Node_t() : m_neighbours(), m_parent(), m_status(WHITE) {}
};

const Node_t::key_t INF = ~0x0;

class Graph {
  // Typedefs
  typedef std::vector<Node_t> graph_t;
 private:
  graph_t m_graph;
  
 public:
  /* Since nodes are 1-counted. */
  Graph(const size_t nodes) : m_graph(nodes+1) {}
  ~Graph() {}
  
  inline void set_capacity(const Node_t::key_t from, const Node_t::key_t to, const int v){
    (m_graph[from].m_neighbours.find(to))->second.m_capacity = v;
  }
  inline void set_rest_capacity(const Node_t::key_t from, const Node_t::key_t to, const int v){
    (m_graph[from].m_neighbours.find(to))->second.m_restCap = v;
  }
  inline void set_flow(const Node_t::key_t from, const Node_t::key_t to, const int v){
    (m_graph[from].m_neighbours.find(to))->second.m_flow = v;
  }
  inline int get_capacity(const Node_t::key_t from, const Node_t::key_t to) const {
    return (m_graph[from].m_neighbours.find(to))->second.m_capacity;
  }
  inline int get_rest_capacity(const Node_t::key_t from, const Node_t::key_t to) const {
    return (m_graph[from].m_neighbours.find(to))->second.m_restCap;
  }
  inline int get_flow(const Node_t::key_t from, const Node_t::key_t to) const {
    return (m_graph[from].m_neighbours.find(to))->second.m_flow;
  }
  
  inline void add_edge(const Node_t::key_t from, const Node_t::key_t to, const Node_t::value_t v) {
    (m_graph[from]).m_neighbours.insert(Node_t::n_vtype(to, v));
  }
  
  void print() const {
    std::cout << "[index, parent, staus] [capacity, restCap, flow]" << std::endl;
    for (unsigned int index = 1; index < m_graph.size(); ++index) {
      std::cout << "[" << index << "," << m_graph[index].m_parent << "," 
		<< m_graph[index].m_status <<  "]\t";
      for (Node_t::c_nItr iitr = (m_graph[index]).m_neighbours.begin(); iitr != (m_graph[index]).m_neighbours.end(); ++iitr)
	std::cout	<< iitr->first << "[" << (iitr->second).m_capacity << "," 
			<< (iitr->second).m_restCap << "," << (iitr->second).m_flow << "]  ";
      std::cout << std::endl;
    }
  }
  
  template <typename InsertIterator>
  void bfs_search(unsigned int start, unsigned int end, InsertIterator result) {
    std::queue<Node_t::key_t> pending;
    // Paint all the nodes white.
    for (Node_t::key_t index = 1; index < m_graph.size(); ++index) {
      (m_graph[index]).m_status = WHITE;
      (m_graph[index]).m_parent = 0; /* Added by manner */
    }
    // Set startnode's parent to INFINITY.
    (m_graph[start]).m_parent = INF;
    
    // Add startnode to the queue.
    pending.push(start);
    while (!pending.empty()) {
      Node_t::key_t v = pending.front();
      pending.pop();
      // Foreach neighbour.
      for (Node_t::nItr itr = (m_graph[v]).m_neighbours.begin(); itr != (m_graph[v]).m_neighbours.end(); ++itr) {
	if (m_graph[itr->first].m_status == WHITE && itr->second.m_restCap
	    /* Added by manner. */ && m_graph[itr->first].m_parent != INF) {
	  m_graph[itr->first].m_status = BLACK; // Saves 3/10 s together with skipping setting to BLACK outside end of for block.
	  pending.push(itr->first);
	  m_graph[itr->first].m_parent = v;
	  
	  // If we find our goal.
	  if (itr->first == end) {
	    Node_t::key_t i = end;
	    while (m_graph[i].m_parent != INF) {
	      assert(i != INF);
	      *result++ = i;
	      i = m_graph[i].m_parent;
	    }
	    *result++ = start;
	    return;
	  }

	}
      }
    }
  }
  
  /*
    for varje kant (u,v) i grafen do 
    f[u,v]:=0; f[v,u]:=0 
    cf[u,v]:=c[u,v]; cf[v,u]:=c[v,u] 
    while det finns en stig p från s till t i restflödesgrafen do 
    r:=min(cf[u,v]: (u,v) ingår i p) 
    for varje kant (u,v) i p do 
    f[u,v]:=f[u,v]+r; f[v,u]:= -f[u,v] 
    cf[u,v]:=c[u,v] - f[u,v]; cf[v,u]:=c[v,u] - f[v,u] 
  */
  
  void ford_fulkerson(std::vector<std::pair<Node_t::key_t, Node_t::key_t> > &c) {
    std::vector<Node_t::key_t> path;
    int s_node = m_graph.size()-2;
    int t_node = m_graph.size()-1;
    bfs_search(s_node, t_node, std::back_inserter(path));

    while (!path.empty()) {
      // Get the minimum rest capacity along the path.
      int r = get_min_res(path);
      for (size_t index = 1; index < path.size(); ++index){
	int u = path[index], v = path[index-1];
	set_flow(u, v, get_flow(u, v)+r); 
	set_flow(v, u, -get_flow(u, v));
	// Set the rest capacity.
	set_rest_capacity(u, v, get_capacity(u, v)-get_flow(u,v));
	set_rest_capacity(v, u,	get_capacity(v, u)-get_flow(v,u));
      }
      
      path.clear(); 
      bfs_search(s_node, t_node, std::back_inserter(path));
    }
    
    /* HACK HACK */
    m_graph[s_node].m_status = BLACK;

    /* Find connections between BLACK & WHITE nodes. */
    for (size_t i = 1; i < m_graph.size(); ++i) {
      if (m_graph[i].m_status == BLACK) {
	for (Node_t::neighbour_t::iterator itr = m_graph[i].m_neighbours.begin(); itr != m_graph[i].m_neighbours.end(); ++itr) {
	  if (m_graph[itr->first].m_status == WHITE)
	    c.push_back(pair<unsigned, unsigned>(i, itr->first));
	}
      }
    }
  }
  
  int get_min_res(const std::vector<Node_t::key_t> &path) const {
    int min = get_rest_capacity(path[1], path[0]);
    for(unsigned int i=1; i < path.size(); ++i)
      min = (get_rest_capacity(path[i], path[i-1]) <  min) ? get_rest_capacity(path[i], path[i-1]) : min;
    return min;
  }
};

struct Point {
  float x, y;
};

int n_cities, n_connections;

unsigned int convert(int x) {
  if (x == 1)
    return n_cities - 1;
  else if (x == 2)
    return n_cities;
  return x - 2;
}

unsigned int unconvert(int x) {
  if (x == n_cities - 1)
    return 1;
  else if (x == n_cities)
    return 2;
  return x + 2;
}

int main() {
  while(scanf("%d %d", &n_cities, &n_connections) != EOF && (n_cities || n_connections)) {
    Graph G(n_cities);
    while (n_connections--) {
      int city1, city2, cost;
      scanf("%d %d %d", &city1, &city2, &cost);
      G.add_edge(convert(city1), convert(city2), cost);
      G.add_edge(convert(city2), convert(city1), cost);
    }

    vector<pair<unsigned int, unsigned int> > v;
    G.ford_fulkerson(v);
    for (vector<pair<unsigned int, unsigned int> >::iterator itr = v.begin(); itr != v.end(); ++itr)
      printf("%d %d\n", unconvert(itr->first), unconvert(itr->second));
    printf("\n");
  }

  return 0;
}
