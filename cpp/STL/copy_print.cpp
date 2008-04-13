#include <algorithm>
#include <iostream>
#include <string>
#include <iterator>

int main(){
  std::string str = "abcdefg";
  std::ostream_iterator<char> output(std::cout);
  std::copy(str.rbegin(), str.rend(), output);
  std::cout << std::endl;
  return 0;
} 
