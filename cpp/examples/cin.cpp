#include <iostream>

int main() {
  int num;
  char c;

  std::cout << "reading ints: " << std::endl;
  while (std::cin >> num) {
    std::cout << num << std::endl;
  }

  std::cout << "reading chars: " << std::endl;
  while (std::cin >> c) {
    std::cout << c << std::endl;
  }
  
  std::cout << "last char: " c << std::endl;
  
}
