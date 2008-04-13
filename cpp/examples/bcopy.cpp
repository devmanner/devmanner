#include <cstring>
#include <iostream>


int main () {
  char payload[20] = "abcdefghijklmnopqrs";
  char data[20];
  

  bcopy(payload, data, 20);

  std::cout << data << std::endl;
  return 0;
}
