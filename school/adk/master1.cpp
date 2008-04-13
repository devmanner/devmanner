#include <vector>
#include <map>
#include <algorithm>
#include <iterator>
#include <iostream>

#include <cstdlib>
#include <cassert>

using namespace std;


template <typename T>
inline T abs(T& x) { return (x < 0) ? x*-1 : x; }

int calcCost(const vector<int> &request, const vector<int> &stops) {
  int cost = 0;
  for (unsigned int i = 0; i < request.size(); ++i) {
    int diff = 100000000;
    // Find least diff.
    for (unsigned int j = 0; j < stops.size(); ++j) {
      if (abs(stops[j] - request[i]) < diff) {
	diff = abs(stops[j] - request[i]);
      }
    }
    cost += (diff * diff);
  }
  return cost;
}


int bruteForce(vector<int> &request, int flats) {
  typedef multimap<int, vector<int>, less<int> > maptype;
  int mincost = 100000;
  vector<int> stops;
  maptype result;
  for (int i = 1; i <= flats; ++i) {
    stops.push_back(i);
    int min = calcCost(request, stops);
    if (min <= mincost) {
      result.insert(maptype::value_type(min, stops));
      mincost = min;
    }
    stops.pop_back();
  }
  
  
  int last = result.begin()->first;
  for (maptype::iterator itr = result.begin(); itr != result.end(); ++itr) {
    if (last != itr->first)
      break;
    cout << "Solution: ";
    copy(itr->second.begin(), itr->second.end(), ostream_iterator<int>(cout, " "));
    cout << " cost: " << itr->first << endl;
  }
  return last;
}

void refine(vector<int> &stops, const vector<int> &request, int levels) {
  cout << "stops: ";
  copy(stops.begin(), stops.end(), ostream_iterator<int>(cout, " "));
  cout << endl;

  int min_cost = 10000;
  vector<int>::iterator itr1 = stops.begin(), itr2 = stops.begin();
  vector<int> temp, optimal;
  for (++itr2; itr2 != stops.end(); ++itr1, ++itr2) {
    temp.clear();
    copy(stops.begin(), itr1, back_inserter(temp));
    copy(itr2+1, stops.end(), back_inserter(temp));
    for (int l = *itr1; l <= *itr2; ++l) {
      temp.push_back(l);
      int cost = calcCost(request, temp);
      if (cost <= min_cost) {
	min_cost = cost;
	optimal.clear();
	copy(temp.begin(), temp.end(), back_inserter(optimal));
      }
      temp.pop_back();
    } 
  }
  
  stops.clear();
  copy(optimal.begin(), optimal.end(), back_inserter(stops));
  cout << "end  : ";
  copy(stops.begin(), stops.end(), ostream_iterator<int>(cout, " "));
  cout << endl;
}


int main() {
  int flats = 10;
  int passangers = 5;
  int stops = 1;

  vector<int> result;
  vector<int> request;

  srand(time(NULL));
  //while (1) {
  /*for (int i = 0; request.size() < passangers; ++i) {
      int tmp = rand()%flats+1;
      if (find(request.begin(), request.end(), tmp) == request.end())
	request.push_back(rand()%flats+1);
    }
  */
  /*  
      request.push_back(35);
      request.push_back(99);
      request.push_back(16);
      request.push_back(65);
      request.push_back(62);
      request.push_back(38);
      request.push_back(33);
      request.push_back(60);
      request.push_back(72);
      request.push_back(80);
*/
      request.push_back(1);
      request.push_back(4);
      request.push_back(5);
      request.push_back(9);
      request.push_back(10);

    sort(request.begin(), request.end());
    
    
    copy(request.begin(), request.end(), back_inserter(result));
    while(result.size() > stops) {
      sort(result.begin(), result.end());
      refine(result, request, flats);
    }
    sort(result.begin(), result.end());
    
    cout << "Passanger want to stop at: ";
    copy(request.begin(), request.end(), ostream_iterator<int>(cout, " "));
    
    cout << endl << "Elavator will stop at: ";
    copy(result.begin(), result.end(), ostream_iterator<int>(cout, " "));
    int costr = calcCost(request, result);
    cout << " cost: " << costr << endl;
    
    int costb = bruteForce(request, flats);
/*if (costb != costr)
      break;
    */
    //  }
  return 0;
}


/*
Solution: 30 65 89  cost: 558
Solution: 30 65 90  cost: 558
Solution: 30 89 65  cost: 558
Solution: 30 90 65  cost: 558
Solution: 31 65 89  cost: 558
Solution: 31 65 90  cost: 558
Solution: 31 89 65  cost: 558
Solution: 31 90 65  cost: 558
Solution: 65 30 89  cost: 558
Solution: 65 30 90  cost: 558
Solution: 65 31 89  cost: 558
Solution: 65 31 90  cost: 558
Solution: 65 89 30  cost: 558
Solution: 65 89 31  cost: 558
Solution: 65 90 30  cost: 558
Solution: 65 90 31  cost: 558
Solution: 89 30 65  cost: 558
Solution: 89 31 65  cost: 558
Solution: 89 65 30  cost: 558
Solution: 89 65 31  cost: 558
Solution: 90 30 65  cost: 558
Solution: 90 31 65  cost: 558
Solution: 90 65 30  cost: 558
Solution: 90 65 31  cost: 558
*/
