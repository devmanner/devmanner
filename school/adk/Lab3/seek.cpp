#include <fstream>
#include <iostream>

int main(int argc, char *argv[]) {
  if (argc != 4) {
    std::cout << "usage: " << argv[0] << " file start stop" << std::endl;
    return -1;
  }

  std::ifstream source(argv[1]);
  source.seekg(atoi(argv[2]));

  while (!source.eof() && source.tellg() <= atoi(argv[3])) {
    std::string s;
    source >> s;
    std::cout << s << std::endl;
    //if (source.tellg() >= atoi(argv[3]))
    //break;
  }
  return 0;
}

