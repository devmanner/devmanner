#include "socklib.h"
#include <iostream>
#include <string>
#include <list>

using namespace std;

int main(int argc, char *argv[]) {
  if (argc != 2) {
    cout << "Usage: " << argv[0] << " port" << endl;
    return 1;
  }

  Socket sock;
  sock.connect("localhost", atoi(argv[1]));
  
  for (int i = 0; i < 10; ++i)
    sock.write(&i, 1);

  return 0;
}
