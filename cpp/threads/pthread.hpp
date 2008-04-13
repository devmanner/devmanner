#ifndef _PTHREAD_HPP_
#define _PTHREAD_HPP_

/**
 * @file	pthread.hpp
 * @author	Tomas Mannerstedt && Kristoffer Roupé
 * @date	2/2-05 
 * @brief	A platform indipendent threadlib for posix threads.
 * @licanse     Free as in beer.
 */

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
}

#ifndef WIN32
#undef Sleep
#include <sys/time.h>

#define Sleep(milli) do{\
struct timespec time={milli*1000,0};\
nanosleep(&time, NULL);\
}while(0);

#else
#include <windows.h> // Sleep
#pragma comment(lib, "pthreadVC1.lib")
#endif

#include <cassert>
#include <cstdlib>

/***
 * @class	cMutex
 * @date	2/2-05
 * @author	Tomas Mannerstedt
 * @brief	A mutex class.
 */
class cMutex {
private:
  pthread_mutex_t m_mutex;
  
  /**
   * @fn		pthread_mutex_t* getHandle() 
   * @return	The handle to the mutex
   * @brief		This function is used by the cCondVar class to get the mutex handle.
   */
  pthread_mutex_t* getHandle() {
    return &m_mutex;
  }
  /**
   * @fn	cMutex(const cMutex &m)
   * @brief	Copy constructor not allowed!
   */
  cMutex(const cMutex &m);
public:
  /**
   * @fn	cMutex()
   * @brief	Constructor.
   * @see	pthread_mutex_init
   */
  cMutex() {
    pthread_mutex_init(&m_mutex, NULL);
  }

  /**
   * @fn	~cMutex()
   * @brief	Destructor.
   * @see	pthread_mutex_destroy
   */
  ~cMutex() {
    pthread_mutex_destroy(&m_mutex);
  }

  /**
   * @ fn		void wait() 
   * @ brief	Wait for the mutex to be free. 
   */
  void wait() {
    pthread_mutex_lock(&m_mutex);
  }

  /**
   * @fn		void unlock()
   * @brief		Unlock the mutex.
   */
  void unlock() {
    pthread_mutex_unlock(&m_mutex);
  }

  /**
   * @brief	cCondVar is a friend class.
   */
  friend class cCondVar;
};

/**
 * @class	cAutolock
 * @date	2/2-05
 * @author	Tomas Mannerstedt
 * @brief	A class used to automatically lock and unlock a cMutex.
 */
class cAutolock {
  cMutex &m_mutex;
  cAutolock(const cAutolock &a);
public:
  /** 
   * @fn	cAutolock(cMutex &m)
   * @param	m	The mutex to be locked.
   * @brief	Constructor that locks the mutex provided.	
   */
  cAutolock(cMutex &m) : m_mutex(m) {
    m_mutex.wait();
  }
  
  /** 
   * @fn	~cAutolock(cMutex &m)
   * @brief	Destructor that unlocks the mutex.	
   */
  ~cAutolock() {
    m_mutex.unlock();
  }
};

/**
 * @class	cSemaphore
 * @date	2/2-05
 * @author	Tomas Mannerstedt
 * @brief	A semaphore class.
 */
class cSemaphore {
private:
  sem_t m_sem;

  /**
   * @fn	cSemaphore(const cSemaphore &s)
   * @brief	Copy constructor not allowed!
   */
  cSemaphore(const cSemaphore &s);
public:
  
  /**
   * @fn	cSemaphore(unsigned int val=0)
   * @param	val		The value to initialize the semaphore with, default = 0.
   * @brief	Constructs a semaphore with the value provided.
   * @see	sem_init
   */
  cSemaphore(unsigned int val=0) : m_sem() {
    sem_init(&m_sem, 0, val);
  }

  /**
   * @fn	~cSemaphore()
   * @brief	Destructor.
   * @see	sem_destroy
   */
  ~cSemaphore() {
    sem_destroy(&m_sem);
  }

  /**
   * @fn	void wait()
   * @brief	Waits for the semaphore.
   */
  void wait() {
    sem_wait(&m_sem);
  }

  /**
   * @fn	void post()
   * @brief	Posts one to the semaphore, unlocking it.
   */
  void post() {
    sem_post(&m_sem);
  }
  
  /**
   * @fn	int get_value()
   * @brief	returns the current value of the semaphore.
   */
  int get_value() {
    int tmp;
    sem_getvalue(&m_sem, &tmp);
    return tmp;
  }
};

/**
 * @class	cCondVar
 * @date	2/2-05
 * @author	Tomas Mannerstedt
 * @brief	A condition variable class.
 */
class cCondVar {
private:
  pthread_cond_t m_cond;
  cCondVar(const cCondVar &c);

public:
  /**
   * @fn	cCondVar()
   * @brief	Constructor of the condition variavble
   * @see	pthread_cond_init
   */
  cCondVar() {
    pthread_cond_init(&m_cond, NULL);
  }

  /**
   * @fn	~cCondVar()
   * @brief	Destructor of the condition variavble
   * @see	pthread_cond_destroy
   */
  ~cCondVar() {
    pthread_cond_destroy(&m_cond);
  }

  /**
   * @fn	void signal()
   * @brief	Signal ONE of the waiting threads.
   */
  void signal() {
    pthread_cond_signal(&m_cond);
  }

  /**
   * @fn	void signalAll()
   * @brief Signal ALL the waiting threads.
   */
  void signalAll() {
    pthread_cond_broadcast(&m_cond);
  }
  /**
   * @fn	void wait(cMutex &mutex)
   * @param	mutex the mutex to be waited for.
   * @brief Unlocks mutex, waits for condition variable and re-locks mutex.
   */
  void wait(cMutex &mutex) {
    pthread_cond_wait(&m_cond, mutex.getHandle());
  }
  /**
   * @fn	template <typename Type, typename BinaryOperator> void wait(cMutex &mutex, const BinaryOperator &op, const Type &x, const Type &y)
   * @param	mutex	An mutex to lock with.
   * @param	op		Value to become true
   * @param	x		x value
   * @param y		y value
   * @brief	Wait for op(var, value) to become true. 
   */
  template <typename Type, typename BinaryOperator>
  void wait(cMutex &mutex, const BinaryOperator &op, const Type &x, const Type &y) {
    mutex.wait();
    while (!op(x, y))
      wait(mutex);
  }
  /*
   * @fn		bool wait(cMutex &mutex, time_t sec, long nsec)
   * @param		mutex	the mutex to wait for.
   * @param		sec		seconds to wait
   * @param		nsec	nanoseconds to wait
   * @brief		Wait for cCondVar for at least sec seconds and nsec nanoseconds.
   * @return	false: Timeout, true: success
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
 * @class	aPThread
 * @date	2/2-05
 * @author	Tomas Mannerstedt 
 * @brief	An abstract class for a thread. 
 *	
 *			The class can be used in two ways:
 *			1)	Overload the run() method. This function will be called repeadly until.
 *				m_bkilled == true (kill() is called that is).
 *			2)	Overload the thread_loop() function. This function will be called once
 *				and the thread will die when control reaches end of this function.
 */
class aPThread {
protected:
  pthread_t m_thread;
  bool m_bkilled;
  struct timespec m_sleeptime;

  /**
   * @fn	static void init_fun(void *t)
   * @param	t	A pointer to the thead to run.
   */
  static void init_fun(void *t) {
    ((aPThread*)t)->run();
  }

  /**
   * @fn	aPThread(const aPThread &t)
   * @brief	Copy constructing not allowed.
   */
  aPThread(const aPThread &t);
public:
  /**
   * @fn	aPThread(time_t sleep_sec=0, long sleep_nsec=0)
   * @param	sleep_sec	time to sleep in sec, default = 0.
   * @param sleep_nsec	time to sleep in nano sec, default = 0.
   * @brief	Constructor that set up the sleep time.
   */
  aPThread(time_t sleep_sec=0, long sleep_nsec=0) : m_thread(), m_bkilled(false) {
    m_sleeptime.tv_sec = (long)sleep_sec;
    m_sleeptime.tv_nsec = (long)sleep_nsec;
  }

  /**
   * @fn	virtual ~aPThread()
   * @brief	Virtual destructor, that ends the looping in thread_loop.
   * @see	pthread_join
   */
  virtual ~aPThread() {
    m_bkilled = true;
    pthread_join(m_thread, NULL);
  }

  /**
   * @fn	virtual void kill() 
   * @brief	Kills the looping in thread_loop.
   */
  virtual void kill() {
    m_bkilled = true;
  }

  /**
   * @fn	void spawn()
   * @brief	creates a thread.
   * @see	pthread_create
   */
  void spawn() {
    pthread_create(&m_thread, NULL, (void*(*)(void*))aPThread::init_fun, (void*)this);
  }

  /**
   * @fn	void wait()
   * @breif	Waits for the thread to finish.
   * @see	pthread_join
   */
  void wait() {
    pthread_join(m_thread, NULL);
  }
  
  /**
   * @fn	void run()
   * @breif	Default thread behavour.
   */
  virtual void run() {
    while (!m_bkilled) {
      thread_loop();
      Sleep(m_sleeptime.tv_nsec*1000);
    }
  }

  /**
   * @fn	void thread_loop()
   * @breif	Overload this method if run is not overloaded.
   */
  virtual void thread_loop() {
  }

  /**
   * @fn	void set_sleeptime()
   * @param	n_sec number of seconds, default = 0.
   * @param	n_nsec number of nanoseconds default = 0.
   * @breif	Set the sleeptime between each call to thread_loop().
   */
  void set_sleeptime(time_t n_sec=0, long n_nsec=0) {
    m_sleeptime.tv_sec = (long) n_sec;
    m_sleeptime.tv_nsec = (long) n_nsec;   
  }
};


#include <list>
#include <algorithm>
#include <iterator>
#include <iostream>

/**
 * @class	cBagOfTasks
 * @date	2/2-05
 * @author	Tomas Mannerstedt 
 * @brief	A template class used to implement the Bag-of-tasks pattern.
 *
 *			If the queue of tasks is empty callers to the add_task() will be the first
 *			to lock the mutex. Get task can return several values:
 *			1: A task was retrieved.
 *			0: No task was retrieved.
 *			-1: No task was retrieved and there will not be any more tasks.
 */
template <typename TaskType>
class cBagOfTasks {
private:
  bool m_bEnd;
  cMutex m_mutex;
  std::list<TaskType> m_tasks;
public:
  /**
   * @fn	cBagOfTasks()
   * @breif	Constructor.
   */
  cBagOfTasks() : m_bEnd(false), m_mutex(), m_tasks() {}

  /**
   * @fn	int get_task(TaskType &s)
   * @param	s will contain a task after a successfull call.
   * @return    1: A task was retrieved, 0: No task was retrieved, -1: No task was retrieved and there will not be any more tasks.
   * @breif	Get a task from the bag.
   */
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

  /**
   * @fn	void add_task(const TaskType &s)
   * @param	s the task to add.
   * @breif	Add a task to the bag.
   */
  void add_task(const TaskType &s) {
    assert(!m_bEnd);
    cAutolock a(m_mutex);
    m_tasks.push_back(s);
  }

  /**
   * @fn	void print()
   * @breif	Print the bag. Requires that TaskType has ostream operator<< overloaded.
   */
  void print() {
    cAutolock a(m_mutex);
    std::copy(m_tasks.begin(), m_tasks.end(), std::ostream_iterator<TaskType>(std::cout, " "));
  }

  /**
   * @fn	void end()
   * @breif	Tell the task that there will not be any more jobs.
   */    
  void end() {
    m_bEnd = true;
  }
};

/**
 * @class	cRandomGenerator
 * @date	2/2-05
 * @author	Tomas Mannerstedt 
 * @brief	A class used to create random numbers. If different threads all try to access srand(time(NULL)) they will all get the same random seed and therefore the same random number. This class takes care of this by generating all random numbers in a separate thread. Uses a combination of  Singleton and reader/writer patterns to implement this functionality. Note: The random generator has to be spawned by calling: cRandomGenerator::get_instance().spawn();
 */
class cRandomGenerator : public aPThread {
private:
  cMutex m_readlock;
  cSemaphore m_reader, m_writer;
  int m_rand;

  cRandomGenerator() : aPThread(), m_readlock(), m_reader(0), m_writer(0), m_rand() {
    srand((unsigned int)time(NULL));
  }
  
public:
  /**
   * @fn	static cRandomGenerator& get_instance()
   * @return    A referance to a cRandomGenerator object.
   * @breif	Add a task to the bag.
   */
  static cRandomGenerator& get_instance() {
    static cRandomGenerator g;
    return g;
  }

  /**
   * @fn	int get_rand()
   * @return    A random numbet produced by rand().
   * @breif	Return a random number.
   */
  int get_rand() {
    cAutolock a(m_readlock);
    int tmp;
    m_reader.post();
    m_writer.wait();
    tmp = m_rand;
    return tmp;
  }

  /**
   * @fn	void thread_loop()
   * @breif	Random generator main loop.
   */
  void thread_loop() {
    m_reader.wait();
    m_rand = rand();
    m_writer.post();
  }

  /**
   * @fn	void kill()
   * @breif	Kill the random generator.
   */
  void kill() {
    cAutolock a(m_readlock);
    m_bkilled = true;
    m_reader.post();
  }
};

#endif
