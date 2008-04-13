#ifndef _WOBJECT_H_
#define _WOBJECT_H_

#pragma warning( disable : 4800 )

#include <iostream>
#include <string>
#include <windows.h>
#include <process.h>
using namespace std;

/*---------------------------------------------------------------------------
class:	aWaitableObject
rev:		2002-09-04
av:     Kristoffer Roupé
anv:		basklass för väntbara object som t.ex.
				mutex, event, thread mm.
---------------------------------------------------------------------------*/
class aWaitableObject{
private:
  aWaitableObject(const aWaitableObject &object);
  aWaitableObject& operator=(const aWaitableObject &object);
  
 protected:
  HANDLE m_hObject;
  
 public:
  aWaitableObject():m_hObject(0)	{ }
  virtual ~aWaitableObject()			{ if(m_hObject)CloseHandle(m_hObject); }
  void wait()											{ tryWait(INFINITE); }
  DWORD tryWait(DWORD mSeconds=0)	{ return WaitForSingleObject(m_hObject, mSeconds); }
  HANDLE getHandle()							{ return m_hObject; }
  operator HANDLE()								{ return m_hObject; }
};


/*---------------------------------------------------------------------------
  class:	Mutex
  rev:		2002-09-04
  arv:    från aWaitableObject
  av:     Kristoffer Roupé
  anv:		mutexlås
  ---------------------------------------------------------------------------*/
class Mutex: public aWaitableObject{
 public:
  Mutex(bool bOwn=false,char *szName=NULL)
    { m_hObject = CreateMutex(NULL, bOwn, szName); }
  ~Mutex()	  										{ }
  bool release()									{ return (bool) ReleaseMutex(m_hObject); }
};

/*---------------------------------------------------------------------------
  class:	Semaphore
rev:		2002-09-04
arv:    från aWaitableObject
av:     Kristoffer Roupé
anv:		Multilås... kan släppa in fler i ett lås. Räknar
				hur många som kommer in o ut!
---------------------------------------------------------------------------*/
class Semaphore: public aWaitableObject{
 public:
  Semaphore(LONG initCount=0, LONG maxCount=MAXLONG, char *szName = NULL)
    { m_hObject = CreateSemaphore(NULL, initCount, maxCount, szName); }
  ~Semaphore()										{ }
  bool release(LONG releaseCount=1)
    { return (bool) ReleaseSemaphore(m_hObject, releaseCount, NULL); }
};

/*---------------------------------------------------------------------------
class:	Event
rev:		2002-09-04
arv:    från aWaitableObject
av:     Kristoffer Roupé
anv:		Händelse för allt möjligt, anv. istället för
				att polla t.ex. en kö mm.
---------------------------------------------------------------------------*/
class Event: public aWaitableObject{
 public:
  Event(bool bManual=false, bool bInitState=false, char *szName = NULL)
    { m_hObject = CreateSemaphore(NULL, bManual, bInitState, szName); }
  ~Event()											{ }
  bool set()										{ return (bool) SetEvent(m_hObject); }
  bool reset()									{ return (bool) ResetEvent(m_hObject); }
  bool pulse()									{ return (bool) PulseEvent(m_hObject); }
};

/*---------------------------------------------------------------------------
class:	aThread
rev:		2002-09-04
arv:    från aWaitableObject
av:     Kristoffer Roupé
anv:		basklass för trådar
---------------------------------------------------------------------------*/
class aThread: public aWaitableObject{
 protected:
  bool bKilled;
  DWORD sleepTime;
  
 public:
  aThread(DWORD time) : sleepTime(time), bKilled(false) {
    m_hObject =  CreateThread(NULL,NULL, runThread,this, CREATE_SUSPENDED, NULL);
  }
  ~aThread(){
    kill();
  }
  void setSleep(DWORD time){
    sleepTime = time;
  }
  virtual void run() {
    bKilled = false;
    ResumeThread(m_hObject);
  }
  void kill(bool bWait=true) {
    bKilled = true;
    if(bWait)
      wait();
  }

  virtual void threadLoop(){ }

  void threadMain(){
    while(!bKilled) {
      threadLoop();
      Sleep(sleepTime);
    }
  }
  
  static DWORD WINAPI	runThread(LPVOID lpVoid){
    ((aThread*)lpVoid)->threadMain();
    return (DWORD) 0;
  }
};

/*---------------------------------------------------------------------------
class:	aBmpThread
rev:		2002-09-04
arv:    från aThead -> aWaitableObject
av:     Kristoffer Roupé
anv:		basklass för trådar som hanterar bilder
---------------------------------------------------------------------------*/
class aBmpThread: public aThread{
protected:
  int				m_x, m_y;
  HDC				m_hdcMem;
  HBITMAP		m_hBitmap;
  BITMAP		m_bitmap;
  string		m_sBmpName;
  HDC				m_hdc;
  HWND			m_hwnd;
  HINSTANCE m_hInstance;
  
 public:
  aBmpThread(int sleep,int x=0, int y=0):m_x(x), m_y(y),m_hdc(0),aThread(sleep)	{ }
  
  ~aBmpThread(){
    DeleteObject(m_hBitmap);
    ReleaseDC(m_hwnd, m_hdc);
  }
  void setX(int x)										{ m_x = x; }
  void setY(int y)										{ m_y = y; }
  int	 getX()const 										{ return m_x; }
  int  getY()const 										{ return m_y; }
  int  getWidth()const 								{ return m_bitmap.bmWidth; }
  int  getHeight()const 							{ return m_bitmap.bmHeight; }
  HDC	 getHdc()const 									{ return m_hdc; }
  HINSTANCE gethInstance()const 			{ return m_hInstance; }
  HWND	gethwnd()const								{ return m_hwnd; }
  virtual void run()									{ bKilled = ((m_sBmpName.c_str() == "") && !(m_hdc) && !(m_hInstance) && !(m_hwnd));
  ResumeThread(m_hObject); }
  virtual void setTarget(HINSTANCE hInstance, HWND hwnd){
    m_hInstance = hInstance;
    m_hwnd = hwnd;
  }
  virtual void init(string name, HINSTANCE hInstance, HWND hwnd)	{
    m_sBmpName = name;
    m_hdc = GetDC(hwnd);
    m_hInstance = hInstance;
    m_hwnd = hwnd;
    m_hBitmap = LoadBitmap(m_hInstance, m_sBmpName.c_str());
    GetObject(m_hBitmap, sizeof(BITMAP), &m_bitmap);
    m_hdc = GetDC(m_hwnd);
  }
};

/*---------------------------------------------------------------------------
class:	autoLock
rev:		2002-10-29
av:     Kristoffer Roupé
anv:		autolås för mutexar objekt, dvs. låser upp automatiskt
---------------------------------------------------------------------------*/
class autoLock{
 private:
  Mutex &m_wObject;
 public:
  autoLock(Mutex & object):m_wObject(object){
    m_wObject.wait();
  }
  ~autoLock(){ 
    m_wObject.release(); 
  }
};



#endif
