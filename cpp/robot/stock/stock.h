#ifndef _STOCK_H_
#define _STOCK_H_

#include <map>
#include <set>
#include <vector>
#include <algorithm>
#include <iostream>
#include <limits.h>
#include <math.h>
#include <assert.h>
using namespace std;

//#define NO_OPTIMIZATION

const int EMPTY = -1;
const int NO_PRODUCTS = 50;
const int RACKSIZE = 22;
const int RACKS = 16;

/*
Internal level:

|------------- map ------------|
              |--- multimap ---|
Product id -> Distance -> place (index in the Lager array)
*/

class Stock {
public:
  typedef multimap<int, int, greater<int> > inner_map_type;
  typedef inner_map_type::value_type inner_map_value_type;
  typedef map<int, inner_map_type, less<int> > map_type;
  typedef map_type::value_type value_type;

private:
  map_type m_stock;
  vector<int> m_prodfreq;
  set<int, less<int> > m_free;			// Holds places
  set<int, less<int> > m_resBoxes;  // Holds places
  set<int, less<int> > m_resPlaces; // Holds places
public:
  Stock(int, int);
  ~Stock();
  
  int reservePlace(int);
  void addProduct(int, int);
  int reserveProduct(int);
  void getProduct(int, int);
  
  void print();
  void draw();
};

/*-------------------------- Functions -----------------------------*/
// Books a place for a box. Returns its place -1 if full.
// Moves a place from free to resPlaces
int Stock::reservePlace(int prod_id){
  cout << m_free.size() << " places left" << endl;
  if (!m_free.size()) {
    cout << "size is: " << m_free.size() << endl;
    return -1;
  }
  int place;
  float prio;
  
  int fq_max = *max_element(m_prodfreq.begin(), m_prodfreq.end());
  //int fq_min = *min_element(m_prodfreq.begin(), m_prodfreq.end());
  fq_max = (fq_max) ? fq_max : 1;
  
  int upper = 1, tries = 0;
  prio = (m_prodfreq[prod_id]/(float)fq_max) * RACKSIZE;

  int rack = 0, offset = 0;
  do {
    upper = (upper) ? 0 : 1;
    offset = rand()%5-2;
    if (upper) // eg lower hehe...
      place = RACKSIZE*2 - (int)(prio+0.5); // max 43, min 22
    else
      place = (int)(prio+0.5)-1; // max 21 min 0
    place = abs((place + RACKSIZE*2*rack) + offset);
    rack = (rack +1) % 16;
  } while((m_free.find(place) == m_free.end() ||
	   m_resPlaces.find(place) != m_resPlaces.end()) &&
          ++tries <= 30);
#ifdef NO_OPTIMIZATION
  place = 0;
#endif
  if (tries > 30 || !place)
    place = *m_free.begin();

  m_free.erase(place);
  m_resPlaces.insert(place);
  return place;
}

// Inserts a box into stock.
// removes a place from resPlaces
void Stock::addProduct(int prod_id, int place){
  map_type::iterator itr = m_stock.find(prod_id);
  (*itr).second.insert(inner_map_value_type((place%(RACKSIZE*2)<=RACKSIZE-1) ? place%(RACKSIZE*2)+1 : RACKSIZE*2-(place%(RACKSIZE*2)), place));
  int tmp = (place%(RACKSIZE*2)<=RACKSIZE-1) ? place%(RACKSIZE*2)+1 : RACKSIZE*2-(place%(RACKSIZE*2));
  if (tmp <= 0)
    cout << "place: " << place << " makes prio: " << tmp << endl;
  m_resPlaces.erase(place);
}

// Books a product, and returns its place
// Removes a product from stock and inserts its place into resBoxes
// Returns -1 if the product does not exist.
int Stock::reserveProduct(int prod_id){
  inner_map_type::iterator itr = (*m_stock.find(prod_id)).second.begin();
  if ((*itr).second == EMPTY)
    return -1;

  m_resBoxes.insert((*itr).second);
  (*m_stock.find(prod_id)).second.erase(itr);
  return (*itr).second;
}

// Removes a product from stock at a specific place witch is also removed from resBoxes
// and inserted into free.
void Stock::getProduct(int place, int prod_id) {
  map_type::iterator itr = m_stock.find(prod_id);
  inner_map_type::iterator iitr = (*itr).second.begin();
  for (;iitr != (*itr).second.end(); ++iitr)
    if ((*iitr).second == place)
      (*itr).second.erase(iitr);
  
  m_resBoxes.erase(place);
  m_free.insert(place);
  m_prodfreq[prod_id] = m_prodfreq[prod_id] + 1;
}

void Stock::print(){
  map_type::iterator oitr;
  inner_map_type::iterator iitr;
  for (oitr = m_stock.begin(); oitr != m_stock.end(); ++oitr)
    for(iitr = (*oitr).second.begin(); iitr != (*oitr).second.end(); ++iitr)
      if ((*iitr).first != EMPTY)
	cout << (*oitr).first << " " << (*iitr).first << " -> " << (*iitr).second << endl;
}

void Stock::draw(){
  /*  HDC hdc = GetDC(m_hwnd);
      m_hdcMem = CreateCompatibleDC(hdc);
      SelectObject(m_hdcMem, m_hBoxes);

	// draw boxes in stock
  for(map_type::iterator itr = m_stock.begin();itr != m_stock.end();++itr)
    for (inner_map_type::iterator iitr = (*itr).second.begin(); iitr != (*itr).second.end(); ++iitr)
	  	BitBlt(	hdc, Lager[(*iitr).second][1], Lager[(*iitr).second][2], 9,9, m_hdcMem, 10,0, SRCCOPY) ;

  // draw reserved boxes
  for(set<int, less<int> >::iterator itr = m_resBoxes.begin();itr != m_resBoxes.end();++itr)
	  	BitBlt(	hdc, Lager[*itr][1], Lager[*itr][2], 9,9, m_hdcMem, 30,0, SRCCOPY) ;

  // draw reserved places
  for(set<int, less<int> >::iterator itr = m_resPlaces.begin();itr != m_resPlaces.end();++itr)
	  	BitBlt(	hdc, Lager[*itr][1], Lager[*itr][2], 9,9, m_hdcMem, 20,0, SRCCOPY) ;

  // draw free slots
  for(set<int, less<int> >::iterator itr = m_free.begin();itr != m_free.end();++itr)
	  	BitBlt(	hdc, Lager[*itr][1], Lager[*itr][2], 9,9, m_hdcMem, 0,0, SRCCOPY) ;

  DeleteDC(m_hdcMem);
  ReleaseDC(m_hwnd, hdc);*/
}


/*---------------------- Constructor/Destructor -------------------------*/

Stock::Stock(int id_max, int n_prod=100) : m_prodfreq(NO_PRODUCTS){
  for (int i = 0; i < id_max; ++i) {
    inner_map_type tmp;
    tmp.insert(inner_map_value_type(EMPTY, EMPTY));
    m_stock.insert(value_type(i, tmp));
  }
  for (int i = 0; i < 2*RACKSIZE*RACKS; ++i)
    m_free.insert(i);
  for (int i = 0; i < NO_PRODUCTS; ++i)
    m_prodfreq[i] = 1;

  srand(time(NULL));
  
  for (int i = 0; i < n_prod; ++i) {
    int place = rand() % 704;
    if (m_free.find(place) != m_free.end()) {
      int prod = rand()%id_max;
      map_type::iterator itr = m_stock.find(prod);
      (*itr).second.insert(inner_map_value_type((place%(RACKSIZE*2)<=RACKSIZE-1) ? place%(RACKSIZE*2)+1 : RACKSIZE*2-(place%(RACKSIZE*2)), place));
      m_free.erase(place);
      m_prodfreq[prod] = m_prodfreq[prod] +1;
    } else {
      --i;
    }
  }
}

Stock::~Stock(){
}

#endif
