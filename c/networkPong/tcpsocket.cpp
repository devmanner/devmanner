#include "tcpsocket.h"

#include <string.h>

#if defined(WIN32)

namespace 
{
	struct WSAHelper
	{
	public:
		WSAHelper(void)
		{
			WSADATA wsadata;
			if(WSAStartup(MAKEWORD(2, 2), &wsadata))
				throw "WSAStartup() failed\n";
		}
			
		~WSAHelper(void){ WSACleanup();}
	}WSAStart;
}
#endif //WIN32

cTCPSocket::cTCPSocket(void):
	m_socket(socket(AF_INET, SOCK_STREAM, 0))
{
//FIXME: better throw
	if(INVALID_SOCKET == m_socket)
		throw "failed to create socket";
}

cTCPSocket::cTCPSocket(socket_t sock):
	m_socket(sock)
{
//FIXME: better throw
	if(INVALID_SOCKET == m_socket)
		throw "failed to create socket";
}

cTCPSocket::~cTCPSocket(void)
{
	close();
}

socket_t cTCPSocket::accept(void)
{
	sockaddr saddr = {0};
	socklen_t addrlen = sizeof(saddr);
	return ::accept(m_socket, &saddr, &addrlen);
}

bool cTCPSocket::bind(unsigned short usPort)
{
	sockaddr_in addr = {AF_INET, htons(usPort), INADDR_ANY};
	return ::bind(m_socket, (sockaddr*)&addr, sizeof(addr)) == 0;
}

bool cTCPSocket::listen(int iBackLog)
{
	return ::listen(m_socket, iBackLog) == 0;
}

bool cTCPSocket::connect(const char* szHost, unsigned short usPort)
{
	sockaddr_in addr = {AF_INET, htons(usPort)};
	if(hostent* phe = gethostbyname(szHost))
		addr.sin_addr = *(in_addr*)phe->h_addr;
	else
		return false;
	return ::connect(m_socket, (sockaddr*)&addr, sizeof(addr)) == 0;
}

bool cTCPSocket::close(void)
{
	return closesocket(m_socket) != 0;
}

size_t cTCPSocket::write(const char *sz)
{
	return write(sz, strlen(sz));
}

size_t cTCPSocket::noBlockRead(void *pDst, int n)
{
	fd_set fds;
	FD_ZERO(&fds);
	FD_SET(*this, &fds);
	timeval time = {0,0};
	if( select(*this + 1, &fds, 0, 0,&time) && ( ::recv(*this, (char*)pDst, n, MSG_PEEK)) >= n)
	  return ::recv(*this, (char*)pDst, n, 0);
	return 0;
}
