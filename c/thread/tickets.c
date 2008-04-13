#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#define AGENTS 5

void* startAgent(void* foo);
int sell(void);

int tickets = 20;

int main() {
  pthread_t agents[AGENTS];
  int cnt;
  printf("Start selling....\n\n");
  for (cnt = 0; cnt < AGENTS; cnt ++)
    if (pthread_create(&agents[cnt], NULL, startAgent, &cnt))
      printf("Problems creating agent %d\n", cnt);

  for (cnt = 0; cnt < AGENTS; cnt ++)
    pthread_join(agents[cnt], NULL);
  return 0;
}

void* startAgent(void* foo) {
  int agent = *foo;
  while (tickets > 0) {
    if(sell()) {
      tickets --;
      printf("Agent %d sold a ticket. %d tickets left.\n", agent, tickets);
    }
  }
  return NULL;
}

int sell(void) {
  return rand() % 2;
}
