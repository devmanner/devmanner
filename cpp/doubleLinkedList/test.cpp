#include <iostream>
#include "dllist.h"

using namespace std;

int main() {
  DLList<int> dll;
  dll.add(1);
  dll.add(2);
  dll.add(3);
  dll.add(4);
  dll.print();

  return 0;
}
