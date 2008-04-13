#include <string>
#include <iostream>
#include "socket.h"

using namespace std;

int main() {
  ServerSocket sock(1111);
  sock.listen();
  sock.accept();
  for(;;) {
    string s1;
    sock.recieve(&s1);
    sock.send(&s1);
    cout << "Server returning: " << s1 << endl;
  }
}
