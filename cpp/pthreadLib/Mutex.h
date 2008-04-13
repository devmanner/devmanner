#ifndef _MUTEX_H_
#define _MUTEX_H_

#include <pthread.h>

class Mutex {
 private:
  pthread_mutex_t m_mutex;
 public:
  Mutex() {
    pthread_mutex_init(&m_mutex, NULL);
  }
  ~Mutex() { pthread_mutex_destroy(&m_mutex); }
  void wait() { pthread_mutex_lock(&m_mutex); }
  bool tryWait() { return pthread_mutex_trylock(&m_mutex) != EBUSY; }
  void release() { pthread_mutex_unlock(&m_mutex); }
};

class AutoLock {
 private:
  Mutex &m_mutex;
 public:
  explicit AutoLock(Mutex &m) : m_mutex(m) { m_mutex.wait(); }
  ~AutoLock() { m_mutex.release(); }
};


#endif
