#include <iostream>
#include <fstream>
#include <algorithm>
#include <iterator>
#include <map>
#include <vector>
#include <sstream>


#include "hasher.h"

const unsigned int LETTERS_IN_HASH = 4;

struct Indexes {
  unsigned int m_start, m_stop;
  Indexes(unsigned int s, unsigned int e) : m_start(s), m_stop(e) { }
  Indexes() {}
};

typedef std::map<unsigned int, Indexes> map_type;

void read_hashes(std::ifstream &in, map_type &m) {
  unsigned int hashc;
  struct Indexes indexes;
  while (in.read((char*)&hashc, sizeof(unsigned int))) {
    in.read((char*)&indexes.m_start, sizeof(unsigned int));
    in.read((char*)&indexes.m_stop, sizeof(unsigned int));
    //    std::cout << "Read: " << hashc << " " << indexes.m_start << " " << indexes.m_stop << std::endl;
    m.insert(map_type::value_type(hashc, indexes));
  }
}

template <typename InsertIterator>
bool get_stage1_pos(std::ifstream &stage1input, std::string &word, unsigned int start,
		    unsigned int stop, InsertIterator itr) {
  stage1input.seekg(start);
  std::string line;
  while (!stage1input.eof() || stage1input.tellg() < (signed)stop) {
    std::getline(stage1input, line);
    if (line.substr(0, word.length()) == word) {
      std::string tmp(find(line.begin(), line.end(), ' '), line.end());
      std::istringstream iss(tmp);
      int x;
      while (iss >> x) {
	*itr = x;
	++itr;
      }
      return true;
    }
  }
  return false;
}

int main(int argc, char *argv[]) {
  if (argc != 5) {
    std::cout << "usage: " << argv[0] << " stage1indexfile stage2indexfile searchfile word" << std::endl;
    return -1;
  }
  
  // The output for stage1.
  std::ifstream stage1input(argv[1]);
  if (!stage1input) {
    std::cout << "Unable to open: " << argv[1] << std::endl;
    return -1;
  }
  
  std::ifstream stage2input(argv[2], std::ios_base::binary | std::ios_base::in);
  if (!stage2input) {
    std::cout << "Unable to open: " << argv[2] << std::endl;
    return -1;
  }
  
  map_type hashes;
  read_hashes(stage2input, hashes);

  std::cout<< "hashtable size: " << hashes.size() << std::endl;
  
  std::vector<unsigned int> pos;

  std::string word(argv[4]);
  if (word.length() > LETTERS_IN_HASH)
    word = word.substr(0, LETTERS_IN_HASH);

  Hasher hash;
  unsigned int hashc = hash(word, word.length());
  std::cout << word << " hash: " << hashc << " len: " << word.length() <<  std::endl;
  map_type::iterator itr = hashes.find(hashc);
  /*
  for (map_type::iterator itr = hashes.begin() ; itr != hashes.end(); ++itr)
    std::cout << itr->first << std::endl;
  */

  if (itr == hashes.end())
    std::cout << "Word not found in hashtable" << std::endl;

  if (itr != hashes.end() && get_stage1_pos(stage1input, word, itr->second.m_start, itr->second.m_stop, back_inserter(pos))) {
    std::ifstream in(argv[3]);
    if (!in) {
      std::cout << "Unable to open: " << argv[3] << std::endl;
      return -1;
    }
    char buf[60];
    for (std::vector<unsigned int>::iterator itr = pos.begin(); itr != pos.end(); ++itr) {
      in.seekg(*itr-30);
      in.read(buf, 60);
      std::cout << "<" << buf << ">" << std::endl;
    }
  }
  else {
    std::cout << "word not found." << std::endl;
    stage1input.close();
    stage2input.close();
    return 0;
  }
  
  stage1input.close();
  stage2input.close();
  
  return 0;
}
