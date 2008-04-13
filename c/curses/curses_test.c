#include <curses.h>
#include <stdio.h>
/*
Compile with:
gcc -Wall -pedantic -lcurses curses_test.c
*/

/* The window pointer. */
WINDOW *mywindow;

int main() {
  int r;
  mywindow = initscr();
  nodelay(mywindow, 1); /* makes getch() a non blocking function. */
  mvprintw(10, 10, "####################");
  mvprintw(11, 10, "ROWS: %d", LINES);

  while ((r = getch()) == ERR)
    ;

  endwin();
  printf("Getch() returnerade: %d\n", r);
  return 0;
}
