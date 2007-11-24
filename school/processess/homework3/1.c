#ifndef _REENTRANT
#define _REENTRANT
#endif

#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>

/*
 * Compile with (no -lposix4 on linux):
 * gcc -Wall 1.c -lpthread -lposix4
 * Run with:
 * ./a.out
 * Define the macro DISABLE_SEMAPHORES to disable the semaphores. I use this
 * to make sure my solution actually works.
 */
//#define DISABLE_SEMAPHORES

#ifdef DISABLE_SEMAPHORES
#undef sem_post
#define sem_post(x)
#undef sem_wait
#define sem_wait(x)
#endif

/* Global semaphores. */
sem_t s2, s3;

/* Functions for the processes. */
void* p1(void* p) {
  printf("Line 1\n");
  printf("Line 2\n");
  sem_post(&s2);
  return NULL;
}
void* p2(void *p) {
  sem_wait(&s2);
  printf("Line 3\n");
  printf("Line 4\n");
  sem_post(&s3);
  return NULL;
}
void* p3(void *p) {
  sem_wait(&s3);
  printf("Line 5\n");
  printf("Line 6\n");
  return NULL;
}

int main() {
  /* Init semaphores */
  sem_init(&s2, 0, 0);
  sem_init(&s3, 0, 0);

  /* Spawn threads. (in wrong order.) */
  pthread_t t1, t2, t3;
  pthread_create(&t3, NULL, p3, NULL);
  pthread_create(&t2, NULL, p2, NULL);
  pthread_create(&t1, NULL, p1, NULL);

  /* Join threads. */
  pthread_join(t1, NULL);
  pthread_join(t2, NULL);
  pthread_join(t3, NULL);

  /* Destroy semaphores. */
  sem_destroy(&s2);
  sem_destroy(&s3);
  
  return 0;
}
