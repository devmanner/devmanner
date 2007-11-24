#include "classes.hpp"
#include "../pthread.hpp"


/*
 * Global invariant: n_females > 0 XOR n_males > 0
 */

cPerson::sex_t cPerson::get_sex() const {
  return m_sex;
}
void cPerson::thread_loop() {
  m_pBath->visit(*this);
  /* Setting some good random sleeptime. */
  set_sleeptime(cRandomGenerator::get_instance().get_rand() % 4, cRandomGenerator::get_instance().get_rand());
}

#ifdef B
void cBathroom::do_things(const cPerson &p) {
  m_inSem.wait();
  printf("%d persons on the toilet\n", 4-m_inSem.get_value());
  struct timespec sleeptime = {0, cRandomGenerator::get_instance().get_rand()};
  printf("A %s is takin' a pee... ", SEX_TO_STR(p.get_sex()));
  nanosleep(&sleeptime, NULL);
  printf("pee took %ld ns\n", sleeptime.tv_nsec);
  m_inSem.post();
}
#else
#ifdef A
void cBathroom::do_things(const cPerson &p) {
  struct timespec sleeptime = {0, cRandomGenerator::get_instance().get_rand()};
  printf("A %s is takin' a pee... ", SEX_TO_STR(p.get_sex()));
  nanosleep(&sleeptime, NULL);
  printf("pee took %ld ns\n", sleeptime.tv_nsec);
}
#else
#warning "Specify -DA or -DB when compileing"
#endif /* ifdef A */
#endif /* ifdef B */

void cBathroom::visit(const cPerson &p) {
  printf("A %s has reached door of bathroom\n", SEX_TO_STR(p.get_sex()));
  m_mutex.wait();
  if (m_sex == cPerson::NOR) {
    printf("Oops, bathroom was empty!\n");
    m_sex = p.get_sex();
    /* Will fall-through to next if. */
  }
  /* Is it only people of my sex in the bathroom? */
  if (m_sex == p.get_sex()) {
    printf("A %s has entered bathroom.\n", SEX_TO_STR(p.get_sex()));
    /* Ok to go in! */
    ++m_nin;
    m_mutex.post();
  }
  else {
    ++m_nwait;
    m_mutex.post();
    printf("A %s is waiting to enter the bathroom\n", SEX_TO_STR(p.get_sex()));
    m_wait.wait();

    /* Entering bathroom. */
    m_mutex.wait();
    ++m_nin;
    m_sex = p.get_sex();
    m_mutex.post();
  }

  do_things(p);
  
  m_mutex.wait();
  --m_nin;
  if (m_nin == 0) {
    if (!m_nwait)
      m_sex = cPerson::NOR;
    else
      for (;m_nwait; m_nwait--)
	m_wait.post();
  }
  m_mutex.post();
}
