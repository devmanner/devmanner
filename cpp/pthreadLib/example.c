#include <pthread.h>
#include <stdio.h>

void print_message_function( void *ptr ); 

main()
{
  pthread_t thread1, thread2;
  char *message1 = "Hello";
  char *message2 = "World";
  
  pthread_create( &thread1, NULL/*pthread_attr_default*/,
		  (void*)&print_message_function, (void*) message1);
  pthread_create(&thread2, NULL/*pthread_attr_default*/, 
		 (void*)&print_message_function, (void*) message2);
  
  exit(0);
}

void print_message_function( void *ptr )
{
  char *message;
  message = (char *) ptr;
  printf("%s ", message);
}
