#ifndef _CLOCK_H_INCLUDED_
#define _CLOCK_H_INCLUDED_

class clock_c
{
	unsigned long m_ulTime;
	int m_iBackground;
	int m_iPointer;
public:
	clock_c(void);
	void draw(void);
	void update(unsigned long m_ulMSec);
};

#endif