#ifndef SOCKET_H_INCLUDED
#define SOCKET_H_INCLUDED

#if defined(WIN32)

#include <winsock.h>
#pragma comment(lib, "ws2_32.lib")

typedef SOCKET socket_t;
typedef int socklen_t;

#else

#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>

#define INVALID_SOCKET -1
typedef int socket_t;

inline int closesocket(socket_t s){ return close(s);}

#endif

#include <stdio.h>

class cTCPSocket
{
	socket_t m_socket;

//no copy or assign
	cTCPSocket(const cTCPSocket&);
	cTCPSocket& operator=(const cTCPSocket);
	size_t noBlockRead(void *pDst, int n);
public:
	enum eBlock {Block = 0, NoBlock = 1};
	typedef unsigned short port_t;
	cTCPSocket(void);
	cTCPSocket(socket_t);
	~cTCPSocket(void);
	bool close(void);

	bool bind(port_t port);
	bool listen(int iBacklog);
	socket_t accept(void);
	bool connect(const char* szHost, unsigned short usPort);

	template <typename T>
	size_t read(T* pDst, int n = 1, int block = Block)
	{
		if(block == NoBlock)
			return noBlockRead(pDst, sizeof(T) * n);
		return ::recv(m_socket, (char*)pDst, sizeof(T) *n, 0);
	}
	
	template <typename T>
	size_t write(const T* pSrc, int n = 1)
	{
		return ::send(m_socket, (const char*)pSrc, sizeof(T) * n, 0);
	}

	size_t write(const char *sz);

	operator socket_t(){ return m_socket;}
};

#endif
