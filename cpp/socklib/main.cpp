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
  sock.bind(atoi(argv[1]));
  sock.listen(1);
  Socket conn(sock.accept());
  
  list<int> l;
  conn.read(back_inserter(l), 10);
  
  for (list<int>::iterator itr = l.begin(); itr != l.end(); ++itr)
    cout << *itr << " ";
  cout << endl;
  
  return 0;
}
