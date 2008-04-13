#include <iostream>
#include "socket.h"

using namespace std;

int main() {
  ServerSocket server(2110);
  ClientSocket client(2110);
  cout << server.listen() << endl;
  client.connect();
  cout << server.accept() << endl;

  client.send("kalle");

  char *c;
  server.recieve(c);
  cout << c << endl;
}
