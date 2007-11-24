#include "pthread.hpp"
#include <unistd.h>

#include <vector>

cSemaphore g_worm, g_dishSem;

class cMotherBird : public aPThread {
  cSemaphore m_emptySem, m_fullSem;
public:
  cMotherBird() : aPThread(0), m_emptySem(0), m_fullSem(0) {
    printf("A mother bird was summoned\n");
  }

  void gather_worms() {
    /* Mother collects a random number of worms. */
    int nworms = (cRandomGenerator::get_instance().get_rand() % 10) + 1;
    printf("Mother gathered %d worm(s)\n", nworms);
    for (;nworms--;)
      g_worm.post();
  }
  void thread_loop() {
    m_emptySem.wait();
    gather_worms();
    m_fullSem.post();    
  }
  void tell_empty() {
    m_emptySem.post();
    /* Wait for mom to fill up. */
    m_fullSem.wait();
  }
};

class cBabyBird : public aPThread {
private:
  int m_id;
  cMotherBird *m_mom;
public:
  cBabyBird(int id, cMotherBird *mom) : aPThread(), m_id(id), m_mom(mom) {
    printf("A baby-bird was born %d\n", m_id);
  }

  void thread_loop() {
    /* The spec said the dish was supposed to be protected by a lock so that
     * only one birs can access it at a time. */
    g_dishSem.wait();
    /* Check how many worms are left on plate. */
    int nworms = g_worm.get_value();
    if (nworms == 0) {
      printf("%d:\tGimmi worms!\n", m_id);
      /* Tell mommy she's got to hunt. */
      m_mom->tell_empty();
    }
    g_worm.wait();
    printf("%d:\tGot a worm.\n", m_id);
    g_dishSem.post();
  }
};


int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s number_of_babys\n", argv[0]);
    return 0;
  }
  /* Init random generator. */
  cRandomGenerator::get_instance().spawn();

  /* Spawn a mother. */
  cMotherBird mother;
  mother.spawn();

  /* Has to be 1 */
  g_dishSem.post();

  /* Create some baby birds. */
  int nBabys = atoi(argv[1]);
  typedef std::vector<cBabyBird*> vec_t;
  vec_t v;
  for (int i = 0; i < nBabys; ++i) {
    v.push_back(new cBabyBird(i, &mother));
    v.back()->spawn();
  }
  
  while(1)
    ;

  for (vec_t::iterator itr = v.begin(); itr != v.end(); ++itr) {
    (*itr)->kill();
    (*itr)->wait();
    delete *itr;
  }
  return 0;
}
