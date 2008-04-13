#ifndef _SOCKET_H_
#define _SOCKET_H_

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

/*
 * A TCP/IPv4 socket.
*/

class Socket {
 protected:
  int m_sockfd;
  struct sockaddr_in m_addr;
  int m_port;
 public:
  Socket(int port) : m_port(port) {
    m_sockfd = socket(AF_INET, SOCK_STREAM, 0);
    
    bzero(&m_addr, sizeof(m_addr));
    m_addr.sin_family = AF_INET;
    m_addr.sin_port = htons(port);
    struct in_addr foo;
    foo.s_addr = htonl(INADDR_ANY);
    m_addr.sin_addr = foo;//htonl(INADDR_ANY);
  }
  virtual ~Socket() {}

  template <class T>
  bool send(T *x) {
    return (::send(m_sockfd, (void*) x, sizeof(T), 0) != -1);
  }
  template <class T>
  bool recieve(T *x) {
    return (recv(m_sockfd, (void*)x, sizeof(T), 0) != -1);
  }
};

class ServerSocket : public Socket {
 private:
 public:
  ServerSocket(int port) : Socket(port) {
    bind(m_sockfd, (struct sockaddr*)&m_addr, sizeof(m_addr));
  }
  bool listen() {
    return (::listen(m_sockfd, 100) != -1);
  }
  int accept() {
    size_t rec_size, sent_size;
    bool success;
    rec_size = sent_size = sizeof(m_addr);
    success = ::accept(m_sockfd, (struct sockaddr*)&m_addr, &rec_size);
    return (success && sent_size == rec_size);
  }
};

class ClientSocket : public Socket {
 private:
 public:
  ClientSocket(int port) : Socket(port) {}
  bool connect() {
    return (::connect(m_sockfd, (struct sockaddr*)&m_addr, sizeof(m_addr)) != -1);
  }
};

#endif
