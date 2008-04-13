#ifndef _SOCKLIB_H_
#define _SOCKLIB_H_

#include <cstring>
#include <iterator>

#ifdef WIN32
/*
 * Do something...
 */
#include <winsock.h>
typedef SOCKET pock_type;
typedef unsigned int port_type;

#else
/*
 * UNIX includes
 */
extern "C" {
#include <unistd.h>
#include <netinet/in.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
}
#include <iostream>
#include <iterator>

typedef int sock_type;
typedef int port_type;

#endif

class Socket {
 private:
  sock_type m_sockfd;
  
 public:
  const sock_type INVALID_SOCKET;

  Socket() : m_sockfd(socket(AF_INET, SOCK_STREAM, 0)), INVALID_SOCKET(-1) {};
  Socket(sock_type conn) : m_sockfd(conn), INVALID_SOCKET(-1) {}
  ~Socket();

  bool bind(port_type port);
  bool listen(int no_pending); // Maxlength of the queue of pending connections. Returns true on success.
  sock_type accept(); // Return a handle to the connection.
  bool connect(const char* hostname, port_type port);

  template <typename T>
  size_t read(T* dest, int n, bool wait=true) {
    if (!wait) {
      fd_set fds;
      FD_ZERO(&fds);
      FD_SET(m_sockfd, &fds);
      timeval time = {0,0};
      if(select(m_sockfd + 1, &fds, 0, 0,&time) && ( ::recv(m_sockfd, (char*)dest, n, MSG_PEEK)) >= n)
	return ::recv(m_sockfd, (char*)dest, n, 0);
      return 0;
    }
    return ::recv(m_sockfd, (char*)dest, sizeof(T) *n, 0);
  }

  template <typename OutputIterator>
  size_t read(OutputIterator start, int n, bool wait=true) {
    size_t size = 0;
    typename std::iterator_traits<OutputIterator>::value_type tmp;
    //int tmp;
    for (int i = 0; i < n; ++i) {
      size += read(&tmp, 1, wait);
      *start = tmp;
      ++start;
    }
    return size;
  }
  
  template <typename T>
  size_t write(const T* source, int n) {
    return ::send(m_sockfd, (const char*)source, sizeof(T) * n, 0);
  }
  template <typename InputIterator>
  size_t write(InputIterator begin, InputIterator end) {
    while (begin != end) {
      write(begin, 1);
      ++begin;
    }
  }
  
  bool close() {
    return !::close(m_sockfd);
  }
  
};

#endif
