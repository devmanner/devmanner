#include "pthread.hpp"
extern "C" {
#include <unistd.h>
#include <stdio.h>
}

static char *stat = "|/-\\|/-\\";

class cStatThread : public aPThread {
private:
	int m_index;
public:
	cStatThread() : aPThread(0, 1000000), m_index(0) {
		
	}

  void thread_loop() {
		static bool first = true;
		if (first) {
			putchar(' ');
			first = false;
		}

		printf("\b%c", stat[m_index++ & 7]);
		fflush(stdout);
	}
};

int main() {
	cStatThread *t = new cStatThread();
	t->spawn();

	sleep(10);

	delete t;
	return 0;
}
