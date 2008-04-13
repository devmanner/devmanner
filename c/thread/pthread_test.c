#include <pthread.h>
#include <stdio.h>

void* messFunc(void *ptr);

int main() {
  pthread_t t1, t2;
  char *mess1 = "Hello ";
  char *mess2 = "world\n";
  printf("Creating thread....\n");

  if (pthread_create (&t1, NULL, messFunc, (void*) mess1) ||
      pthread_create (&t2, NULL, messFunc, (void*) mess2))
    printf("Error creating thread!\n");

  return 0;
}

void* messFunc(void *ptr) {
  printf("%s", (char*) ptr);
}
