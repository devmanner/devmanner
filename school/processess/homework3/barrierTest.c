/* matrix summation using pthreads

   features: uses a barrier; the Worker[0] computes
             the total sum from partial sums computed by Workers
             and prints the total sum to the standard output

   usage on Solaris:
     gcc matrixSum.c -lpthread -lposix4
     a.out size numWorkers

*/
#ifndef _REENTRANT 
#define _REENTRANT 
#endif 
#include <pthread.h>
#include <stdio.h>

/* For atoi on Linux */
#include <stdlib.h>

#define SHARED 0 
#define MAXSIZE 100  /* maximum matrix size */
#define MAXWORKERS 4   /* maximum number of workers */

//pthread_mutex_t barrier;  /* mutex lock for the barrier */
//pthread_cond_t go;        /* condition variable for leaving */
int numWorkers;
int numArrived = 0;       /* number who have arrived */


/* BEGIN BARRIER */
#include <semaphore.h>
int count = 0; /* counter */
sem_t arrive, go; /* semaphores */
/* Function to init the barrier. Better encapsulation than if init was done in main() */
void barrier_init(void) {
  count = 0;
  sem_init(&arrive, 0, 1);
  sem_init(&go, 0, 0);
}
/* The barrier function. Argument is the number of workers to arrive before barrier is released. */
void barrier(int h) {
  int i;
  sem_wait(&arrive);
  ++count;
  if (count == h) {
    printf("A worker is releasing barrier!\n");
    for (i = 0; i < h-1; ++i)
      sem_post(&go);
    sem_post(&arrive);
    return;
  }
  sem_post(&arrive);
  printf("A worker is waiting for go...\n");
  sem_wait(&go);
  printf("A worker got go!\n");
}
/* Destroy the barrier. */
void barrier_destroy(void) {
  sem_destroy(&arrive);
  sem_destroy(&go);
}
/* END BARRIER */


/* a reusable counter barrier */
/*
void Barrier() {
  pthread_mutex_lock(&barrier);
  numArrived++;
  if (numArrived == numWorkers) {
    numArrived = 0;
    pthread_cond_broadcast(&go);
  } else
    pthread_cond_wait(&go, &barrier);
  pthread_mutex_unlock(&barrier);
}
*/
int size, stripSize;  /* assume size is multiple of numWorkers */
int sums[MAXWORKERS];
int matrix[MAXSIZE][MAXSIZE];
void *Worker(void *);

/* read command line, initialize, and create threads */
int main(int argc, char *argv[]) {
  int i, j;
  pthread_attr_t attr;
  pthread_t workerid[MAXWORKERS];

  /* Start up barrier. */
  barrier_init();
  
  /* set global thread attributes */
  pthread_attr_init(&attr);
  pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

  /* initialize mutex and condition variable */
  //pthread_mutex_init(&barrier, NULL);
  //pthread_cond_init(&go, NULL);

  /* read command line args if any */
  size = (argc > 1)? atoi(argv[1]) : MAXSIZE;
  numWorkers = (argc > 2)? atoi(argv[2]) : MAXWORKERS;
  if (size > MAXSIZE) size = MAXSIZE;
  if (numWorkers > MAXWORKERS) numWorkers = MAXWORKERS;
  stripSize = size/numWorkers;

  /* initialize the matrix */
  for (i = 0; i < size; i++)
    for (j = 0; j < size; j++)
      matrix[i][j] = 1;
  printf("Size is: %d and the number of workers are: %d\n", size, numWorkers);
  /* create the workers, then exit */
  for (i = 0; i < numWorkers; i++)
    pthread_create(&workerid[i], &attr, Worker, (void *) i);
  pthread_exit(NULL);
}

/* Each worker sums the values in one strip of the matrix.
   After a barrier, worker(0) computes and prints the total */
void *Worker(void *arg) {
  int myid = (int) arg;
  int total, i, j, first, last;

  printf("worker %d (pthread id %d) has started\n", myid, pthread_self());

  /* determine first and last rows of my strip */
  first = myid*stripSize;
  last = first + stripSize - 1;

  /* sum values in my strip */
  total = 0;
  for (i = first; i <= last; i++)
    for (j = 0; j < size; j++)
      total += matrix[i][j];
  sums[myid] = total;

  /* Call the barrier */
  barrier(numWorkers);

  if (myid == 0) {
    total = 0;
    for (i = 0; i < numWorkers; i++)
      total += sums[i];
    printf("the total is %d\n", total);
    /* Let the last worker destroy the barrier. */
    barrier_destroy();
  }
  return NULL;
}
