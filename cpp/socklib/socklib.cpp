#include "socklib.h"

/*
 * Initialization of constants.
 */

//const sock_type Socket::INVALID_SOCKET = -1;

/*
 * Functions.
 */


Socket::~Socket() {
  close();
}

bool Socket::bind(port_type port) {
  struct sockaddr_in addr;
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_ANY);
  addr.sin_port = htons(port);
  return (::bind(m_sockfd, (struct sockaddr *) &addr, sizeof(addr)) >= 0);
}

bool Socket::listen(int no_pending) {
  return !::listen(m_sockfd, no_pending);
}

sock_type Socket::accept() {
  return ::accept(m_sockfd, (struct sockaddr *) NULL, 0); // Maybe not... perhaps return some more information...
}

bool Socket::connect(const char* hostname, port_type port) {
  struct sockaddr_in addr;
  struct hostent *hent = gethostbyname(hostname);
  if (!hent)
    return false;

  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr = *((struct in_addr *) hent->h_addr);
  addr.sin_port = htons(port);
  return !::connect(m_sockfd, (struct sockaddr *) &addr, sizeof(struct sockaddr));
}

/*
template <typename T>
size_t Socket::read(T* dest, int n) {
  return ::recv(m_socket, (char*)dest, sizeof(T) *n, 0);
}

template <typename T>
size_t Socket::write(const T* source, int n) {
  return ::send(m_socket, (const char*)source, sizeof(T) * n, 0);
}
*/
