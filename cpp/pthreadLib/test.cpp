#include <iostream>
#include <stdio.h>
#include "aThread.h"
#include "Mutex.h"

using namespace std;

Mutex mutex;
int i = 0;

class Thread : public aThread {
private:
  char m_op;
public:
  Thread(char operation, int sleep=0, bool wait=false) : aThread(sleep, wait), m_op(operation) {printf("Thread::Thread()\n"); }
  ~Thread() { }
  void threadLoop() {
    AutoLock(mutex);
    if (m_op == '+')
      printf("Plus: i is %d\n", ++i);
    else 
      printf("Munis: i is %d\n", --i);
  }
};

int main() {
  printf("Creating thread...\n");
  Thread t1('+', 1, false);
  Thread t2('-', 2, false);

  printf("Thread started, shall be running...\n");

  cin.get();
  return 0;
}
