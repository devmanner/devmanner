#include <algorithm>
#include <iostream>
#include <string>
#include <iterator>

int main(){
  std::string str;
  // Läs in en sträng.
  std::getline(std::cin, str);
  // Kopiera strängen bakifrån och fram till en ostream_iterator kopplad till stdout.
  std::copy(str.rbegin(), str.rend(), std::ostream_iterator<char> (std::cout));
  return 0;
} 
