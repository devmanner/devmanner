#include <curses.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

/*
Compile with:
gcc -Wall -pedantic -lcurses foo.c
*/

/* The window pointer. */
WINDOW *mywindow;

#define XOFF 15
#define YOFF 20

#define L1X 10
#define L1Y 10
#define L1Z 10
#define L2X 10
#define L2Y -10
#define L2Z 10
#define L3X -10
#define L3Y 10
#define L3Z 10
#define L4X -10
#define L4Y -10
#define L4Z 10


int main() {
  int key, x=0, y=0, z=0;
  mywindow = initscr();
  nodelay(mywindow, 1); /* makes getch() a non blocking function. */
  noecho(); /* Be quiet! */

  while ((key = getch()) != 27) { /* Until Esc */
    mvprintw(y+YOFF, x+XOFF, "%d", z);
    switch (key) {
    case ('w'): /* NORTH */
      mvprintw(y+YOFF, x+XOFF, " ");
      --y;
      break;
    case ('s'): /* SOUTH */
      mvprintw(y+YOFF, x+XOFF, " ");
      ++y;
      break;
    case ('d'): /* EAST */
      mvprintw(y+YOFF, x+XOFF, " ");
      ++x;
      break;
    case ('a'): /* WEST */
      mvprintw(y+YOFF, x+XOFF, " ");
      --x;
      break;
    case ('k'): /* UP */
      mvprintw(y+YOFF, x+XOFF, " ");
      ++z;
      break;
    case ('m'): /* DOWN */
      mvprintw(y+YOFF, x+XOFF, " ");
      --z;
      break;
    }
    mvprintw(0, 1, "L1: %.2f", sqrt(pow(abs(L1X-x), 2) + pow(abs(L1Y-y), 2) + pow(abs(L1Z-z), 2))); 
    mvprintw(1, 1, "L2: %.2f", sqrt(pow(abs(L2X-x), 2) + pow(abs(L2Y-y), 2) + pow(abs(L2Z-z), 2))); 
    mvprintw(2, 1, "L3: %.2f", sqrt(pow(abs(L3X-x), 2) + pow(abs(L3Y-y), 2) + pow(abs(L3Z-z), 2))); 
    mvprintw(3, 1, "L4: %.2f", sqrt(pow(abs(L4X-x), 2) + pow(abs(L4Y-y), 2) + pow(abs(L4Z-z), 2))); 
    mvprintw(4, 1, "POS: (%d, %d, %d)      ", x, y, z); 

  }
  echo(); /* You may talk now... */
  endwin();
  return 0;
}
