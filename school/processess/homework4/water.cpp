#include "pthread.hpp"

#include <cstdio>
#include <vector>

/*
 * This program is developed using gcc 3. You may have problems compileing it
 * with older versions of gcc since they do not handle namespaces, c-headers
 * and templates according to the standard. I have compiled the code with gcc
 * 3.3 compilers on both linux and solaris 5.9 (my.nada.kth.se) and it works
 * fine (at least to compile).
 * To compile on solaris:
 * g++ -Wall water.cpp -lpthread -lposix4
 * To compile on linux:
 * g++ -Wall water.cpp -lpthread
*/

static const int FREE = 0;
static const int READY = 1;
static const int CONSUMED = 2;

class WaterCreator {	
private:
  int *m_hready; // Status of the H atoms
  cMutex m_mutex;
  cCondVar m_cond;
  int m_hcnt; // Number of arrived H atoms
  int m_hdone; // index of first unconsumed H atom
  int m_ncreated; // Number of created molecules.
  
  WaterCreator(const WaterCreator &c);
public:
  WaterCreator(const int no) : m_hready(new int[no*2]), m_mutex(), m_cond(), m_hcnt(0), m_hdone(0), m_ncreated(0) {
  }
  ~WaterCreator() {
    delete [] m_hready;
  }

  void oReady() {
    m_mutex.wait();    
    int hindex = m_hdone; // Pick two H-atoms to wait for.
    m_hdone += 2;
    printf("An O is waiting for H: %d and %d\n", hindex, hindex+1);

    m_cond.signalAll();
    
    m_mutex.unlock();
    m_cond.wait(m_mutex, std::equal_to<int>(), m_hready[hindex], READY);
    m_mutex.unlock();
    m_cond.wait(m_mutex, std::equal_to<int>(), m_hready[hindex+1], READY);
    /* Only one thread can make water since the mutex is taken here. */
    makeWater(hindex);
    m_mutex.unlock();
  }

  void hReady() {
    m_mutex.wait();
    int hindex = m_hcnt; // Get who I am.
    m_hcnt++;
    m_hready[hindex] = READY;
    m_cond.signalAll();
    
    m_mutex.unlock();
    m_cond.wait(m_mutex, std::equal_to<int>(), m_hready[hindex], CONSUMED);
    m_mutex.unlock();
  }
  void makeWater(int hindex) {
    m_hready[hindex] = CONSUMED;
    m_hready[hindex+1] = CONSUMED;
    m_cond.signalAll();
    printf("Made water molecule number: %d\n", ++m_ncreated);
  }
};

class O : public aPThread {
private:
  WaterCreator *m_creator;
  int m_id;
public:
  O(WaterCreator *w, int id) : m_creator(w), m_id(id) {
  }
  ~O() {
  }
  void run() {
    struct timespec sleeptime = {cRandomGenerator::get_instance().get_rand() % 4, cRandomGenerator::get_instance().get_rand()};
    nanosleep(&sleeptime, NULL);
    printf("O atom %d is ready\n", m_id);
    m_creator->oReady();
    printf("O atom %d was consumed.\n", m_id);
  }
};

class H : public aPThread {
private:
  WaterCreator *m_creator;
  int m_id;
public:
  H(WaterCreator *w, int id) : m_creator(w), m_id(id) {
  }
  ~H() {
  }
  void run() {
    struct timespec sleeptime = {cRandomGenerator::get_instance().get_rand() % 4, cRandomGenerator::get_instance().get_rand()};
    nanosleep(&sleeptime, NULL);
    printf("H atom %d is ready\n", m_id);
    m_creator->hReady();
    printf("H %d atom was consumed.\n", m_id);
  }
};

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s number_of_O_atoms\n", argv[0]);
    return 0;
  }

  /* Init random generator. */
  cRandomGenerator::get_instance().spawn();

  int nO = atoi(argv[1]);
  WaterCreator creator(nO);
  std::vector<O*> o;
  std::vector<H*> h;

  for (int i = 0; i < nO; ++i) {
    o.push_back(new O(&creator, i));
    o.back()->spawn();
  }
  for (int i = 0; i < nO*2; ++i) {
    h.push_back(new H(&creator, i));
    h.back()->spawn();
  }
  
  for (std::vector<O*>::iterator itr = o.begin(); itr != o.end(); ++itr) {
    (*itr)->wait();
    delete *itr;
  }
  for (std::vector<H*>::iterator itr = h.begin(); itr != h.end(); ++itr) {
    (*itr)->wait();
    delete *itr;
  }

  /* Kill the random generator thread. */
  cRandomGenerator::get_instance().kill();
  cRandomGenerator::get_instance().wait();
  
  puts("All H and O atoms consumed.");
  
  return 0;
}
