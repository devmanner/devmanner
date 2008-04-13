#include <stdio.h>
#include <ncurses.h>

int main() {
  int key;
  printf("Press a key\n");
  getch();
  while (key = getch() == 0)
    ;
  printf("The key was: %d\nStopped!\n", key);

}

