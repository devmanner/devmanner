#include <string>
#include <iostream>
#include "socket.h"

using namespace std;

int main() {
  ClientSocket sock(1111);
  sock.connect();
  char buff[80];
  while (fgets(buff, 80, stdin) != NULL) {
    string s(buff), s2;
    sock.send(&s);
    sock.recieve(&s2);
    cout << s2 << endl;
  }
}
