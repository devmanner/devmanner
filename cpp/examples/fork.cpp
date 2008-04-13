#include <cstdio>
#include <cassert>

#include <cstdlib>

extern "C" {
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
}

class aProcess {
protected:
  pid_t m_pid;
  
public:
  aProcess() : m_pid(0) {
  }

  virtual void parent(void)=0;
  virtual void child(void)=0;

  pid_t spawn(void) {
    m_pid = fork();
    if (!m_pid)
      child();
    else
      parent();
    return m_pid;
  }  
};



int main() {
  class Process : public aProcess {
    void parent() {
      printf("This is a parent, child gor pid: %u\n", m_pid);
      wait((int*)WNOHANG);
    }
    void child(void) {
      printf("This is a spawned process!\n");
      system("sleep 1");
    }
  };

  Process p;
  p.spawn();

  return 0;
}

