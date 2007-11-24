/*
usage on Solaris:
gcc matrixSum.c -lpthread -lposix4
a.out size numWorkers

To compile on linux:
gcc matrixSum.c -lpthread -DLINUX
The -DLINUX is used to define the LINUX macro. This makes a call to nanosleep after
examined row. I use this to make sure i get a context switch. Otherwise only a few
of the created threads will work. The comments in the file shall explain what is
done.
a.out size numWorkers
*/

#ifndef _REENTRANT 
#define _REENTRANT 
#endif 
#include <pthread.h>
#include <stdio.h>

/* Added for atoi() on linux */
#include <stdlib.h>

#define SHARED 0 
#define MAXSIZE 100  /* maximum matrix size */
#define MAXWORKERS 4   /* maximum number of workers */

/* Macro for problem A */
#define MIN(x, y) ((x < y) ? x : y)

pthread_mutex_t barrier;  /* mutex lock for the barrier */
pthread_cond_t go;        /* condition variable for leaving */
int numWorkers;
int numArrived = 0;       /* number who have arrived */

/* a reusable counter barrier */
void Barrier() {
  pthread_mutex_lock(&barrier);
  numArrived++;
  if (numArrived == numWorkers) {
    numArrived = 0;
    pthread_cond_broadcast(&go);
  }
  else
    pthread_cond_wait(&go, &barrier);
  pthread_mutex_unlock(&barrier);
}

int size, stripSize;  /* assume size is multiple of numWorkers */
int mins[MAXSIZE];
int matrix[MAXSIZE][MAXSIZE];
void *Worker(void *);
int getJob(void);

/* read command line, initialize, and create threads */
int main(int argc, char *argv[]) {
  int i, j;
  pthread_attr_t attr;
  pthread_t workerid[MAXWORKERS];

  /* For problem B */
  int min;

  /* Init random seed. */
  srand(time(NULL));

  /* set global thread attributes */
  pthread_attr_init(&attr);
  pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

  /* initialize mutex and condition variable */
  pthread_mutex_init(&barrier, NULL);
  pthread_cond_init(&go, NULL);

  /* read command line args if any */
  size = (argc > 1)? atoi(argv[1]) : MAXSIZE;
  numWorkers = (argc > 2)? atoi(argv[2]) : MAXWORKERS;
  if (size > MAXSIZE) size = MAXSIZE;
  if (numWorkers > MAXWORKERS) numWorkers = MAXWORKERS;
  stripSize = size/numWorkers;

  /* initialize the matrix to some random values. */
  for (i = 0; i < size; i++)
    for (j = 0; j < size; j++)
      matrix[i][j] = rand() & 127;

  /* Print out the matrix. */
  for (i = 0; i < size; i++) {
    for (j = 0; j < size; j++)
      printf("%3d ", matrix[i][j]);
    printf("\n");
  }

  /* create the workers, then exit */
  for (i = 0; i < numWorkers; i++)
    pthread_create(&workerid[i], &attr, Worker, (void *) i);
  
  /* Wait on threads. */
  for (i = 0; i < numWorkers; i++)
    pthread_join(workerid[i], NULL);

  /* Calculate the minimum of all minimums. */
  min = mins[0];
  for (i = 1; i < size; i++)
    min = MIN(min, mins[i]);
    
  printf("Minimum: %d\n", min);

  return 0;
}

/* Each worker sums the values in one strip of the matrix.
   After a barrier, worker(0) computes and prints the total */
void *Worker(void *arg) {
  int myid = (int) arg;
  int i;
  int row;
  /* Set sleeptime to 1 ns. */
#ifdef LINUX
  struct timespec sleeptime = {0, 1};
#endif

  printf("worker %d (pthread id %d) has started\n", myid, pthread_self());

  /* Get a job */
  while ((row = getJob()) != -1) {
    /* Get the maximum of that row. */
    int min = matrix[row][0];
    for (i = 1; i < size; i++)
      min = MIN(min, matrix[row][i]);
    mins[row] = min;
    printf("Worker: %d found minimum: %d on row: %d\n", myid, min, row);
#ifdef LINUX
    /* Just make sure we get a context-switch, much more interesting then. */
    nanosleep(&sleeptime, NULL);
#endif
  }
  return NULL;
}


/*
 * Return a job id, that is a row in the matrix. Return -1 if no more jobs.
 */
int getJob(void) {
  static int init = 1;
  static pthread_mutex_t mutex;
  static int job_cnt = -1;
  int job;
  
  /* Init mutex if first call. */
  if (init) {
    pthread_mutex_init(&mutex, NULL);
    init = 0;
  }

  /* Are there any job left? */
  if (job_cnt == size-1) {
    return -1;
  }

  pthread_mutex_lock(&mutex);
  job = ++job_cnt;
  pthread_mutex_unlock(&mutex);
  
  return job;
}
