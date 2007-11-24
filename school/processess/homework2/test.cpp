#include "../lib/pthread.hpp"

#include <cstdio>
#include <ctime>

class cThread : public aPThread {
private:
  int m_cnt;
  int m_id;
public:
  cThread(int id) : aPThread(id), m_cnt(0), m_id(id) {
  }
  ~cThread() {}

  void run() {
    printf("%d = %d\n", m_id, ++m_cnt);
    sleep(1);
    if (m_cnt == 5)
      m_bkilled = true;
  }
};

int main() {
  cThread t1(1), t2(2);
  t1.spawn();
  t2.spawn();

  printf("Waiting...\n");

  t1.wait();
  t2.wait();

  return 0;
}
