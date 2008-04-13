#ifndef _ATHREAD_H_
#define _ATHREAD_H_

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

class aThread {
 protected:
  bool m_bKilled, m_bWait;
  pthread_t m_ptHandle;
  //  struct timespec m_sleep;
  unsigned int m_sleep;
  static void* runThread(void *p) {
    printf("aThread::runThread\n");
    ((aThread*)p)->threadMain();
    return NULL;
  }

 public:
  aThread(int sleep=0, bool wait=true) : m_bKilled(false), m_bWait(wait), m_ptHandle(0), m_sleep(sleep) {
    /*
    m_sleep.tv_sec = (int) sleep;
    m_sleep.tv_nsec = (int) (sleep - m_sleep.tv_sec);
    */
    printf("aThread::aThread starting thread\n");
    pthread_attr_t detached_attr;
    
    int status = pthread_attr_init(&detached_attr);
    if (status!=0)
      printf("pthread_attr_init!=0\n");
    status = pthread_attr_setdetachstate(&detached_attr, PTHREAD_CREATE_DETACHED);
    if (status!=0)
      printf("pthread_attr_setdetachstate!=0\n");
    pthread_create(&m_ptHandle, &detached_attr, &runThread, (void *) this);
    pthread_attr_destroy(&detached_attr);
  }
  virtual ~aThread() {
    m_bKilled = true;
  }
  void threadMain() {
    while (!m_bKilled) {
      threadLoop();
      //pthread_delay_np(&m_sleep);
      sleep(m_sleep);
    }
    pthread_exit(NULL);
  }
  virtual void threadLoop();
  void run() {
    ;// resume thread.
  }
  void kill() {
    m_bKilled = true;
    if (m_bWait)
      ; // wait for thread
  }
};

#endif
