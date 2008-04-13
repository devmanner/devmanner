#include <iostream>

using namespace std;

struct nfo {
  int x, y, z; // typ  
};

class CommandFactory {
private:
  CommandFactory() { }
public:
  CommandFactory* get_instance() {
    static CommandFactory f;
    return &f;
  }
  Command* produce(char c, int num) {
    switch (c) {
    case 'G':
      return new GCommand();
      break;

    }
  }
};

class Command {
private:
public:
  virtual Command() {}
  virtual void execute() =0;
};

class GCommand00_01 : public Command {
private:
  struct nfo m_info;
  int m_num;
public:
  GCommand(int num, struct nfo info) : m_info(info), m_num(num); { }
  void execute() {
    cout << "G" << m_num << "\t" 
	 << "X: " << m_info.x 
	 << " Y: " << m_info.y 
	 << " Z: " << m_info.z << endl; 
  }
};

class GCommand02_06 : public Command {
private:
  list<Command> m_list;
public:
  GCommand02_06(int num, struct nfo info) {
    switch(num) {
    case (02):
      
      break;
    }
  }
  void execute() {
    for (each in m_list)
      itr->execute();
  }
};

int main() {

  return 0;
}
