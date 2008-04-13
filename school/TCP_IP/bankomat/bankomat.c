#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include "jltio.h"

#define BUFF_SIZE 10
#define PORT 8083

int handleConnecton(int connfd, int savings) {
  int i = 0;
  char buff[BUFF_SIZE] = {0};
  printf("Begin handle connection... confd: %d\n", connfd);
  
  while(1) {
    readline(connfd, &buff[i], 1024);
    ++i;
    printf(".");
    if (!bcmp(buff, "foo", 3))
      break;
  }
  
  printf("buff: %s", buff);
  //writen(connfd, (void*) return_str, sizeof(char)*strlen(filecont));

  return 0;
}

int main(int argc, char *argv[]) {
  int listenfd, connfd;
  socklen_t clilen;
  pid_t childpid;
  struct sockaddr_in cliaddr, servaddr;
  
  listenfd = socket(AF_INET, SOCK_STREAM, 0);    
  bzero(&servaddr, sizeof(servaddr));
  servaddr.sin_family      = AF_INET;
  servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  servaddr.sin_port        = htons(PORT);
  
  bind(listenfd, (struct sockaddr *) &servaddr, sizeof(servaddr));
  
  listen(listenfd, 20);
  for ( ; ; ) {
    clilen = sizeof(cliaddr);
    connfd = accept(listenfd, (struct sockaddr *) &cliaddr, &clilen);
    
    if ( (childpid = fork()) == 0) {
      close(listenfd);
      exit(handleConnecton(connfd, 10)); // dummy
    }
  }
}
