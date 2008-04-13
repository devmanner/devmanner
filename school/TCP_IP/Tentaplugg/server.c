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

#define MAX_FILESIZE 1024
#define MAX_LINE 80

void handleConn(int sockfd) {
  writen(sockfd, "kalle", strlen("kalle"));
}

int main(int argc, char *argv[]) {
  int	listenfd, connfd;
  socklen_t clilen;
  pid_t childpid;
  struct sockaddr_in cliaddr, servaddr;
  
  if (argc != 2) {
    printf("Usage: %s port\n", argv[0]);
    return -1;
  }
  
  listenfd = socket(AF_INET, SOCK_STREAM, 0);    
  memset(&servaddr, 0, sizeof(servaddr));
  servaddr.sin_family      = AF_INET;
  servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  servaddr.sin_port        = htons(atoi(argv[1]));
  


  if (bind(listenfd, (struct sockaddr *) &servaddr, sizeof(servaddr)) < 0) {
    perror("Bind failed");
  }


  listen(listenfd, 20);
  for ( ; ; ) {
    clilen = sizeof(cliaddr);
    connfd = accept(listenfd, (struct sockaddr *) &cliaddr, &clilen);
    if (connfd == -1) {
      perror("accept misslyckades");
    }
    
    if ( (childpid = fork()) == 0) { 
      close(listenfd);
      printf("Handle connection\n");
      handleConn(listenfd);
      close(listenfd);
      exit(0);
    }
    
    close(listenfd);
  }
}
