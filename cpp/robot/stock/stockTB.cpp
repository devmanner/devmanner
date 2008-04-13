#include <iostream>
#include "stock.h"
using namespace std;

int main() {
  Stock s(3);
/*
  for (int i = 0; i < 50 ; ++i) {
		switch (i%2){
			case 0:
		  	s.addProduct(2, s.reservePlace(2));
      break;
			case 1:
   		  s.addProduct(1, s.reservePlace(1));
      break;
    }
  }
*/
	
  for (int i = 0; i < 604 ; ++i) {
    int place = s.reservePlace(2);
    if (place == -1)
      cout << "error" << endl;
    else
      s.addProduct(2, place);
  }

  int place = 0;
  int picks = 0;
  do {
    place = s.reserveProduct(2);
    if (place != -1) {
      s.getProduct(place, 2);
      picks ++;
    }
  } while (place != -1);
  cout << "picks: " << picks << endl;
  //s.print();
  
  //  cin.get();
  return 0;
}

