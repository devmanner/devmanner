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

/*
#define WWW_ROOT "/home/tdi00tma.ht00.users/TCPIP/Lab1/Uppg2/www_root/"
#define FOURoFOUR_DOC "/home/tdi00tma.ht00.users/TCPIP/Lab1/Uppg2/www_root/404.html"
*/

#define WWW_ROOT "/home/tomas/c-source/sockets/Uppg2/www_root/"
#define FOURoFOUR_DOC "/home/tomas/c-source/sockets/Uppg2/www_root/404.html"

#define MAX_FILESIZE 1024
#define MAX_LINE 80

void handleConnecton(int connfd) {
    char buff[80];
    char *header = "HTTP/1.0 200 OK\nDate: Fri, 31 Dec 1999 23:59:59 GMT\nContent-type: text/html\n";
    char req_file[80];
    FILE *fileh;
    char fname[strlen(WWW_ROOT) + 80];
    size_t fsize;
    char filecont[MAX_FILESIZE];
    char return_str[MAX_FILESIZE*2];
    bzero(filecont, MAX_FILESIZE);
    printf("Begin handle connection...\n");
    while (readline(connfd, buff, MAX_LINE)) {
	printf("%s", buff);
	if (!bcmp(buff, "GET", 3)) {
	    char *p;
	    if ((p = (char*) memccpy(req_file, buff+5, ' ', MAX_LINE-5)) == NULL)
		printf("Fuckface and the assholes!\n");
	    *(--p) = '\0';	    
	}
	if (!bcmp(buff, "\r\n", 2))
	    break;
    }

    /*
     * Get the file.
     */
    printf("Getting the file...\n");
    strcat(fname, WWW_ROOT);
    strcat(fname, req_file);
    printf("Opening: %s\n", fname);
    if((fileh = fopen(fname, "r")) == NULL)
	if((fileh = fopen(FOURoFOUR_DOC, "r")) ==NULL)
	    printf("404 doc not found!");
    printf("Reading...\n");
    fsize = fread((void*) filecont, sizeof(char), MAX_FILESIZE, fileh);
    fclose(fileh);
    printf("File read.\nContens is:\n%s", filecont);

    /*
     * Return some headers...
     */
    /*    
    strcat(return_str, header);
    sprintf(header, "Content-length: %d\n", fsize);
    strcat(return_str, header);
    */
    strcat(return_str, filecont);
    
    /*
     * Return the file.
     */
    writen(connfd, (void*) return_str, sizeof(char)*strlen(filecont));
    printf("Returning:\n%s", return_str);
    close(connfd);
}

int main() {
    int	listenfd, connfd;
    socklen_t clilen;
    pid_t childpid;
    struct sockaddr_in cliaddr, servaddr;

    listenfd = socket(AF_INET, SOCK_STREAM, 0);    
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family      = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port        = htons(8080);
    
    bind(listenfd, (struct sockaddr *) &servaddr, sizeof(servaddr));
    
    listen(listenfd, 20);
    for ( ; ; ) {
	clilen = sizeof(cliaddr);
	connfd = accept(listenfd, (struct sockaddr *) &cliaddr, &clilen);
	
	if ( (childpid = fork()) == 0) {
	    close(listenfd);
	    handleConnecton(connfd);
	    exit(0);
	}
    }
}
