#ifndef _PTHREAD_HPP_
#define _PTHREAD_HPP_

#ifndef _REENTRANT
#define _REENTRANT
#endif

/* Check compiler version. */
#ifdef __GNUC__
#if ( __GNUC__ != 3 )
#warning "This program may not compile with gcc versions < 3"
#endif
#endif

extern "C" {
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
}

#include <cassert>
#include <cstdlib>

/***
 * Class: cMutex
 * Description: A mutex class.
 * Methods: wait() Wait for the mutex to be free.
 * unlock() Lock the mutex.
 */
class cMutex {
private:
  pthread_mutex_t m_mutex;
  
  /* This function is used by the cCondVar class to get the mutex handle. */
  pthread_mutex_t* getHandle() {
    return &m_mutex;
  }
  cMutex(const cMutex &m);
public:
  cMutex() {
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

  friend class cCondVar;
};

/***
 * Class: cAutolock
 * Description: A class used to automatically lock and unlock a cMutex.
*/
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

/***
 * Class: cSemaphore
 * Description: A semaphore class.
 */
class cSemaphore {
private:
  sem_t m_sem;
  cSemaphore(const cSemaphore &s);
public:
  cSemaphore(unsigned int val=0) : m_sem() {
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
  int get_value() {
    int tmp;
    sem_getvalue(&m_sem, &tmp);
    return tmp;
  }
};

/***
 * Class: cCondVar (condition variable)
 * Description: A condition variable class.
 */
extern "C" {
#include <sys/time.h>
}

class cCondVar {
private:
  pthread_cond_t m_cond;
  cCondVar(const cCondVar &c);

public:
  cCondVar() {
    pthread_cond_init(&m_cond, NULL);
  }
  ~cCondVar() {
    pthread_cond_destroy(&m_cond);
  }

  /* Signal ONE of the waiting threads. */
  void signal() {
    pthread_cond_signal(&m_cond);
  }
  /* Signal ALL the waiting threads. */
  void signalAll() {
    pthread_cond_broadcast(&m_cond);
  }
  /* Unlocks mutex, waits for condition variable and re-locks mutex. */
  void wait(cMutex &mutex) {
    pthread_cond_wait(&m_cond, mutex.getHandle());
  }
  /* Wait for op(var, value) to become true. */
  template <typename Type, typename BinaryOperator>
  void wait(cMutex &mutex, const BinaryOperator &op, const Type &x, const Type &y) {
    mutex.wait();
    while (!op(x, y))
      wait(mutex);
  }
  /***
   * Wait for cCondVar for at least sec seconds and nsec nanoseconds.
   * Return value:
   * false: Timeout
   * true: success
   */
  /*
  bool wait(cMutex &mutex, time_t sec, long nsec) {
    struct timeval now;
    struct timespec timeout;
    gettimeofday(&now, NULL);
    timeout.tv_sec = now.tv_sec + sec;
    timeout.tv_nsec = now.tv_usec * 1000 + nsec; 
    int retcode = pthread_cond_timedwait(&m_cond, mutex.getHandle(), &timeout);
    return retcode != ETIMEDOUT
  }
  */
};


/***
 * Class: aPThread
 * Description: An abstract class for a thread. The class can be used in two
 * ways:
 * 1) Overload the run() method. This function will be called repeadly until.
 * m_bkilled == true (kill() is called that is).
 * 2) Overload the thread_loop() function. This function will be called once
 * and the thread will die when control reaches end of this function.
 */
class aPThread {
protected:
  pthread_t m_thread;
  bool m_bkilled;
  struct timespec m_sleeptime;

  static void init_fun(void *t) {
    ((aPThread*)t)->run();
  }

  aPThread(const aPThread &t);

public:
  aPThread(time_t sleep_sec=0, long sleep_nsec=0) : m_thread(), m_bkilled(false) {
    m_sleeptime.tv_sec = sleep_sec;
    m_sleeptime.tv_nsec = sleep_nsec;
  }
  virtual ~aPThread() {
    m_bkilled = true;
    pthread_join(m_thread, NULL);
  }

  virtual void kill() {
    m_bkilled = true;
  }

  void spawn() {
    pthread_create(&m_thread, NULL, (void*(*)(void*))aPThread::init_fun, (void*)this);
  }

  void wait() {
    pthread_join(m_thread, NULL);
  }
  
  /* This is the default behavour of the run() function. */
  virtual void run() {
    while (!m_bkilled) {
      thread_loop();
      nanosleep(&m_sleeptime, NULL);
    }
  }
  virtual void thread_loop() {
  }
  void set_sleeptime(time_t n_sec=0, long n_nsec=0) {
    m_sleeptime.tv_sec = n_sec;
    m_sleeptime.tv_nsec = n_nsec;   
  }
};


/***
 * Class: cBagOfTasks
 * Description: A template class used to implement the Bag-of-tasks pattern.
 * If the queue of tasks is empty callers to the add_task() will be the first
 * to lock the mutex. Get task can return several values:
 * 1: A task was retrieved.
 * 0: No task was retrieved.
 * -1: No task was retrieved and there will not be any more tasks.
 */

/* Structure used for the cBagOfTasks */
#include <list>
#include <algorithm>
#include <iterator>
#include <iostream>

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

/*
 * Class: cRandomGenerator
 * Descriotion: A class used to create random numbers. If different threads
 * all try to access srand(time(NULL)) they will all get the same random seed
 * and therefore the same random number. This class takes care of this by
 * generating all random numbers in a separate thread. Uses a combination of 
 * Singleton and reader/writer patterns to implement this functionality.
 * Note: The random generator has to be spawned by calling:
 * cRandomGenerator::get_instance().spawn();
 */
class cRandomGenerator : public aPThread {
private:
  cMutex m_readlock;
  cSemaphore m_reader, m_writer;
  int m_rand;

  cRandomGenerator() : aPThread(), m_readlock(), m_reader(0), m_writer(0), m_rand() {
    srand(time(NULL));
  }
  
public:
  static cRandomGenerator& get_instance() {
    static cRandomGenerator g;
    return g;
  }
  int get_rand() {
    cAutolock a(m_readlock);
    int tmp;
    m_reader.post();
    m_writer.wait();
    tmp = m_rand;
    return tmp;
  }

  void thread_loop() {
    m_reader.wait();
    m_rand = rand();
    m_writer.post();
  }

  void kill() {
    cAutolock a(m_readlock);
    m_bkilled = true;
    m_reader.post();
  }
};

#endif
