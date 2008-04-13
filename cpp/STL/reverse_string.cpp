#include <algorithm>
#include <iostream>
#include <string>
#include <iterator>

int main(){
  std::string str;
  // L�s in en str�ng.
  std::getline(std::cin, str);
  // Kopiera str�ngen bakifr�n och fram till en ostream_iterator kopplad till stdout.
  std::copy(str.rbegin(), str.rend(), std::ostream_iterator<char> (std::cout));
  return 0;
} 
