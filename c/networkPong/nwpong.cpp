/*
m = 109
k = 107
Esc = 27
*/


#include <string>
#include <ncurses.h>
#include <unistd.h>
#include <time.h>

#include "tcpsocket.h"

using namespace std;

class Screen {
private:
  WINDOW *m_window;
  Screen() {
    m_window = initscr();    
    /* make getch() a non blocking function. */
    nodelay(m_window, 1);
    noecho();
  }
public:
  static Screen& get_instance() {
    static Screen screen;
    return screen;
  }
  void printAt(int x, int y, string s) {
    mvprintw(y, x, (char*)s.c_str());
  }
  void endScreen() {
    echo();
    endwin();
  }
  int getKey() {
    return ::getch();
  }
};

class Court {
private:
  int m_max_x;
  int m_max_y;
  Court(int x, int y) : m_max_x(x), m_max_y(y){ }
public:
  static Court& get_instance() {
    static Court c(80, 20);
    return c;
  }
  void paint(){
    for (int i = 0; i < m_max_x; ++i) {
      Screen::get_instance().printAt(i, 0, string("#"));
      Screen::get_instance().printAt(i, m_max_y, string("#"));
    }
    for (int i = 0; i < m_max_y; ++i) {
      Screen::get_instance().printAt(0, i, string("#"));
      Screen::get_instance().printAt(m_max_x, i, string("#"));
    }
  }
  int maxX() { return m_max_x; }
  int maxY() { return m_max_y; }
};


class Paddle {
private:
  int m_x;
  int m_y; // Top position
  int m_height;
public:
  Paddle(int x, int y, int h) : m_x(x), m_y(y), m_height(h) {
  }
  void up() {
    if (m_y > 1)
      --m_y;
    Screen::get_instance().printAt(m_x, m_y, string("|"));
    Screen::get_instance().printAt(m_x, m_y+m_height+1, string(" "));
  }
  void down() {
    if (m_y < Court::get_instance().maxY() - m_height - 1)
      ++m_y;
    Screen::get_instance().printAt(m_x, m_y-1, string(" "));
    Screen::get_instance().printAt(m_x, m_y+m_height, string("|"));
  }
  void paint() {
    for(int y = m_y; y < m_y + m_height; ++y)
      Screen::get_instance().printAt(m_x, y, string("|")); 
  }
  void onPaddle(int &x, int &y, int &sx){
    if (x == m_x && (y >= m_y && y <= m_y + m_height)) {
      sx *= -1;
      paint();
    }
  }
  int getY() { return m_y; }
};

class Point {
private:
  int m_p1;
  int m_p2;
  Point() : m_p1(0), m_p2(0) {}
public:
  static Point& get_instance() {
    static Point p;
    return p;
  }
  int p1Get() { return m_p1; }
  int p2Get() { return m_p2; }
  int p1Add() { return ++m_p1; }
  int p2Add() { return ++m_p2; }
};


class Ball {
private:
  int m_x;
  int m_y;
  int m_sx;
  int m_sy;
public:
  Ball(int x, int y, int sx, int sy) : m_x(x), m_y(y), m_sx(sx), m_sy(sy) {
  }
  ~Ball() {}
  void update(Paddle *paddle1, Paddle *paddle2) {
    Screen::get_instance().printAt(m_x, m_y, string(" "));
    paddle1->onPaddle(m_x, m_y, m_sx);
    paddle2->onPaddle(m_x, m_y, m_sx);

    if (m_x <= 1 || m_x >= Court::get_instance().maxX()-1) {
      m_sx *= -1;
      if (m_x <= 1)
	Point::get_instance().p1Add();
      else
	Point::get_instance().p2Add();
    }
    if (m_y <= 1 || m_y >= Court::get_instance().maxY()-1)
      m_sy *= -1;
    m_x += m_sx;
    m_y += m_sy;
    Screen::get_instance().printAt(m_x, m_y, string("¤"));
  }
  int getX() { return m_x; }
  int getY() { return m_y; }
};


int main(int argc, char[] *argv) {
  /*
   * Open the socket
   */
  cTCPSocket sock;
  sock.bind(7772);
  sock.listen(10);
  printf("Wait...\n");
  cTCPSocket conn(sock.accept());
  
  const struct timespec wait = {0, 1};
  Ball ball(10, 3, 1, -1);

  Paddle paddle(3, 8, 5);
  paddle.paint();
  Paddle net_paddle(77, 8, 5);
  net_paddle.paint();

  Court::get_instance().paint();

  int key = 0;
  bool run = true;
  int net_val;
  while (run) {
    nanosleep(&wait, NULL);
    key = Screen::get_instance().getKey();

    /*
     * Get data from other side...
     */
    if (conn.read(&net_val, 1, cTCPSocket::NoBlock)) {
      Screen::get_instance().printAt(10, 10, string(buff));
      switch (net_val) {
      case 107: net_paddle.up(); break;
      case 109: net_paddle.down(); break;
      case 27: run = false; break;
      default: break;
      }
    } else
      net_val = 0;
 

    switch (key) {
    case 107: paddle.up(); break;
    case 109: paddle.down(); break;
    case 27: run = false; break;
    case ERR:
    default: break;
    }
    ball.update(&paddle, &net_paddle);
    key = 0;
    char buff[80] = {(char)ball.getX(), (char)ball.getY(), (char)paddle.getY(), (char)net_paddle.getY(), (char)Point::get_instance().p1Get(), (char)Point::get_instance().p2Get()};
    if (!conn.write(buff, 6))
      run = false;
    sprintf(buff, "P1: %d\tP2: %d", Point::get_instance().p1Get(), Point::get_instance().p2Get());
    Screen::get_instance().printAt(1, 22, string(buff));
  }

  Screen::get_instance().endScreen();
}
