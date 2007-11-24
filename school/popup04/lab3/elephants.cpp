#include <vector>
#include <set>
#include <algorithm>
#include <iterator>
#include <iostream>
#include <cassert>
#include <cstdio>

/*
  Finn längsta kedja med stigande vikt och minskande iq.
*/

using namespace std;

#define MAX 1000



int g_id = 1;

struct Elephant {
  Elephant(int _weight, int _iq) : weight(_weight), iq(_iq), id(g_id) { ++g_id; }

  Elephant(const Elephant &e) : weight(e.weight), iq(e.iq), id(e.id) { }

  int weight;
  int iq;
  int id;
};

template <typename T>
class ElephantIdSorter {
public:
  bool operator()(const T &e1, const T &e2) {
    return ( e1.id < e2.id);
  }
};

class ElephantIncrIqSorter {
public:
  bool operator()(const Elephant &e1, const Elephant &e2) {
    return ( e1.iq < e2.iq || (e1.weight < e2.weight && e1.iq == e2.iq) );
  }
};

class ElephantDecrIqSorter {
public:
  bool operator()(const Elephant &e1, const Elephant &e2) {
    return ( e1.iq > e2.iq || (e1.weight > e2.weight && e1.iq == e2.iq) );
  }
};


int main() {
  int iq, weight;
  
  vector<Elephant> elephs;

  while (scanf("%d %d", &weight, &iq) != EOF)
    elephs.push_back(Elephant(weight, iq));

#ifdef DBG
  printf("iq\tweight\tid\n");
  for (vector<Elephant>::iterator itr = elephs.begin(); itr != elephs.end(); ++itr)
    printf("%d\t%d\t%d\n", itr->iq, itr->weight, itr->id);
#endif

  ElephantDecrIqSorter s;
  sort(elephs.begin(), elephs.end(), s);
  
#ifdef DBG
  printf("iq\tweight\tid\n");
  for (vector<Elephant>::iterator itr = elephs.begin(); itr != elephs.end(); ++itr)
    printf("%d\t%d\t%d\n", itr->iq, itr->weight, itr->id);
  

#endif  /*
    length[i] = Längden av lägsta kedjan om sista elefantan är elefant i.
  */
  
  int n_elephs = elephs.size();
  int *length = (int*) malloc(n_elephs * sizeof(int));
  int *last = (int*) malloc(n_elephs * sizeof(int));
  for (int i = 0; i < n_elephs; ++i) {
    length[i] = 1;
    last[i] = -1;
  }

  for (int i = 1; i < n_elephs; ++i) {
    assert(length[i] >= 1);
    int max_lj = 0;
    for (int j = 0; j < i; ++j) {
      if (elephs[j].weight < elephs[i].weight && length[j] > max_lj) {
	max_lj = length[j];
	last[i] = j;
      }
    }
    length[i] = max_lj + 1;
  }

#ifdef DBG
  printf("\nlength:\t");
  copy(length, &length[n_elephs], ostream_iterator<int>(cout, " "));
  printf("\nlast:\t");
  copy(last, &last[n_elephs], ostream_iterator<int>(cout, " "));
  printf("\n");
#endif

  vector<Elephant> sol;
  int index = distance(length, max_element(length, &length[n_elephs]));
  while (index != -1) {
    sol.push_back(elephs[index]);
    index = last[index];
  }
  
  ElephantDecrIqSorter iqs;
  sort(sol.begin(), sol.end(), iqs);

  printf("%d\n", sol.size());
  for (vector<Elephant>::iterator itr = sol.begin(); itr != sol.end(); ++itr)
    printf("%d\n", itr->id);

  free(last);
  free(length);
  return 0;
}
