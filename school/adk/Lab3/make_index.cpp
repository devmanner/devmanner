#include <iostream>
#include <fstream>
#include <set>
#include <algorithm>
#include <iterator>

#include "hasher.h"

const int LETTERS_IN_HASH = 4;


void stage1(std::ofstream &stage1output) {
  /*
   * Merge the lines from stdin.
   */
  std::string word;
  unsigned int pos;

  typedef std::set<unsigned int> set_type;
  set_type pos_set; // To store the positions of a word sorted.

  std::cin >> word;  
  while (!std::cin.eof()) {
    std::cin >> pos;
    pos_set.insert(pos);

    std::string next_word;    
    std::cin >> next_word;
    // While we read the same word, store the position in pos_set.
    while (next_word == word) {
      std::cin >> pos;
      pos_set.insert(pos);
      std::cin >> next_word;
    }
    
    // Print output: word positions.
    stage1output << word << " ";
    std::copy(pos_set.begin(), pos_set.end(), std::ostream_iterator<set_type::value_type>(stage1output, " "));
    stage1output << std::endl;
    pos_set.clear();
    
    word = next_word;
  }
}

// Get the first four letters or until first ' '.
std::string reduce_string(std::string &s) {
  std::string tmp = s.substr(0, LETTERS_IN_HASH);
  return std::string(tmp.begin(), find(tmp.begin(),tmp.end(), ' '));
}

void stage2(std::ifstream &stage1input, std::ofstream &stage2output) {
  std::string line;
  Hasher hash;
  std::string last_word, word;
  unsigned int first_pos, last_pos, before_read;
  first_pos = last_pos = stage1input.tellg();

  while(!stage1input.eof()) {
    before_read = stage1input.tellg();

    std::getline(stage1input, line);
    word = reduce_string(line);
    if (last_word != word && !last_word.empty()) {
      // We can hash the whole string since we've called reduce_string erlier.
      unsigned int hashc = hash(last_word, last_word.length());
      stage2output.write((char*)&hashc, sizeof(unsigned int));
      stage2output.write((char*)&first_pos, sizeof(unsigned int));
      stage2output.write((char*)&last_pos, sizeof(unsigned int));
    }
    else {
      last_pos = before_read;
    }
    last_word = word;
  }
}


int main(int argc, char *argv[]) {
  if (argc != 3) {
    std::cout << "usage: " << argv[0] << " stage1indexfile stage2indexfile" << std::endl;
    return -1;
  }
  
  // The output for stage1.
  std::ofstream stage1output(argv[1]);
  if (!stage1output) {
    std::cout << "Unable to open: " << argv[1] << std::endl;
    return -1;
  }
  stage1(stage1output);
  stage1output.close();

  std::ofstream stage2output(argv[2], std::ios_base::binary | std::ios_base::out | std::ios_base::trunc);
  if (!stage2output) {
    std::cout << "Unable to open: " << argv[2] << std::endl;
    return -1;
  }
  std::ifstream stage1input(argv[1]);
  if (!stage1input) {
    std::cout << "Unable to open: " << argv[1] << std::endl;
    return -1;
  }

  stage2(stage1input, stage2output);
  stage1input.close();
  stage2output.close();

  return 0;
}
