#ifndef _CLASSES_HPP_
#define _CLASSES_HPP_

#include "../pthread.hpp"

class cBathroom;

#define SEX_TO_STR(sex) (sex == cPerson::MALE ? "male" : "female")

class cPerson : public aPThread {
public:
  typedef enum {MALE, FEMALE, NOR} sex_t;
private:
  sex_t m_sex;
  cBathroom *m_pBath;
  
public:
  cPerson(sex_t sex, cBathroom *b) : aPThread(1, 0), m_sex(sex), m_pBath(b) {
    printf("A person with sex: %s was born.\n", SEX_TO_STR(sex));
  }
  ~cPerson() {
    printf("A person with sex: %s died\n", SEX_TO_STR(m_sex));
  }
  cPerson::sex_t get_sex() const;
  void thread_loop();
};

#ifdef B
class cBathroom {
private:
  cSemaphore m_inSem;
  cSemaphore m_mutex;
  cSemaphore m_wait;
  cPerson::sex_t m_sex;
  int m_nin, m_nwait;
public:
  cBathroom() : m_inSem(4), m_mutex(1), m_wait(), m_sex(cPerson::NOR), m_nin(0), m_nwait(0) {}
  void do_things(const cPerson &p);
  void visit(const cPerson &p);
};

#else
#ifdef A
class cBathroom {
private:
  cSemaphore m_mutex;
  cSemaphore m_wait;
  cPerson::sex_t m_sex;
  int m_nin, m_nwait;
public:
  cBathroom() : m_mutex(1), m_wait(), m_sex(cPerson::NOR), m_nin(0), m_nwait(0) {}
  void do_things(const cPerson &p);
  void visit(const cPerson &p);
};

#else
#warning "Specify -DA or -DB when compileing"
#endif
#endif

#endif
