#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdlib.h>
#include <unistd.h>
#include "jltio.h"

#define MAX_FILESIZE 1024
#define MAX_LINE 80

int main(int argc, char *argv[]) {
  int sockfd;
  struct hostent *hent;
  char buff[MAX_LINE];

  struct sockaddr_in servaddr;

  if (argc != 3) {
    printf("Usage: %s host port\n", argv[0]);
    return -1;
  }
  
  if (!(hent = gethostbyname(argv[1])))
    perror("gethostbyname");

  memset(&servaddr, 0, sizeof(servaddr));
  servaddr.sin_family      = AF_INET;
  servaddr.sin_addr = *((struct in_addr *) hent->h_addr);
  servaddr.sin_port        = htons(atoi(argv[2]));
  
  sockfd = socket(AF_INET, SOCK_STREAM, 0);

  connect(sockfd, (struct sockaddr *) &servaddr, sizeof(struct sockaddr));

  while (readline(sockfd, buff, MAX_LINE) > 0) {
    printf("Buff: %s", buff);
  }


  return 0;
}
