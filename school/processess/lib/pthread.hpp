#ifndef _REENTRANT
#define _REENTRANT
#endif

extern "C" {
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
}

#include <cassert>

/* Structure used for the cBagOfTasks */
#include <list>
#include <algorithm>
#include <iterator>
#include <iostream>

class aWaitable {
protected:
  aWaitable() {}
  virtual ~aWaitable() {}
  virtual void wait()=0;
};

class cMutex : public aWaitable {
private:
  pthread_mutex_t m_mutex;
public:
  cMutex() : aWaitable() {
    pthread_mutex_init(&m_mutex, NULL);
  }
  ~cMutex() {
    pthread_mutex_destroy(&m_mutex);
  }
  void wait() {
    pthread_mutex_lock(&m_mutex);
  }
  void unlock() {
    pthread_mutex_unlock(&m_mutex);
  }
};

class cAutolock {
  cMutex &m_mutex;
  cAutolock(const cAutolock &a);
public:
  cAutolock(cMutex &m) : m_mutex(m) {
    m_mutex.wait();
  }
  ~cAutolock() {
    m_mutex.unlock();
  }
};

class cSemaphore {
private:
  sem_t m_sem;
public:
  cSemaphore(unsigned int val) : m_sem() {
    sem_init(&m_sem, 0, val);
  }
  ~cSemaphore() {
    sem_destroy(&m_sem);
  }
  void wait() {
    sem_wait(&m_sem);
  }
  void post() {
    sem_post(&m_sem);
  }
};

class aPThread : public aWaitable {
protected:
  pthread_t m_thread;
  bool m_bkilled;
  struct timespec m_sleeptime;

  void thread_loop() {
    while (!m_bkilled) {
      run();
      nanosleep(&m_sleeptime, NULL);
    }
  }
  static void thread_fun(void *t) {
    ((aPThread*)t)->thread_loop();
  }

public:
  aPThread(unsigned int sleep_nsec=0) : aWaitable(), m_thread(), m_bkilled(false) {
    m_sleeptime.tv_sec = 0;
    m_sleeptime.tv_nsec = sleep_nsec;
  }
  virtual ~aPThread() {
    m_bkilled = true;
    pthread_join(m_thread, NULL);
  }

  void kill() {
    m_bkilled = true;
  }

  void spawn() {
    pthread_create(&m_thread, NULL, (void*(*)(void*))aPThread::thread_fun, (void*)this);
  }

  void wait() {
    pthread_join(m_thread, NULL);
  }
  
  virtual void run()=0;
};

template <typename TaskType>
class cBagOfTasks {
private:
  bool m_bEnd;
  cMutex m_mutex;
  std::list<TaskType> m_tasks;
public:

  cBagOfTasks() : m_bEnd(false), m_mutex(), m_tasks() {}

  int get_task(TaskType &s) {
    if (m_bEnd && m_tasks.empty())
      return -1;
    else if (m_tasks.empty())
      return 0;

    cAutolock a(m_mutex);
    if (m_bEnd && m_tasks.empty())
      return -1;
    else if (m_tasks.empty())
      return 0;
    s = m_tasks.front();
    m_tasks.pop_front();
    return 1;
  }

  void add_task(const TaskType &s) {
    assert(!m_bEnd);
    cAutolock a(m_mutex);
    m_tasks.push_back(s);
  }

  void print() {
    cAutolock a(m_mutex);
    std::copy(m_tasks.begin(), m_tasks.end(), std::ostream_iterator<TaskType>(std::cout, " "));
  }
  
  void end() {
    m_bEnd = true;
  }
};
